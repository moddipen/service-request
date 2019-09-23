<?php

namespace App\Http\Controllers\Api\Auth;

use App\Mail\EmailVerification;
use App\Mail\ResetPassword;
use App\Models\Authenticator;
use App\Models\CompanyUser;
use App\Models\ContractorUser;
use App\Models\SubscriptionPlan;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Str;

class UserController extends Controller
{

    /**
     * @var Authenticator
     */
    private $authenticator;

    /**
     * UserController constructor.
     * @param Authenticator $authenticator
     */
    public function __construct(Authenticator $authenticator)
    {
        $this->authenticator = $authenticator;
    }

    /**
     * @param $user
     * @return bool
     */
    private function checkParentActivation($user)
    {
        $role = $user->getRoleNames()[0];
        if ($role == 'Company admin') {
            return true;
        }
        if ($role == 'Company editor' || $role == 'Site admin' || $role == 'Contractor admin') {
            if ($user->hasCompany->company->trashed()) {
                return false;
            } else if (!$user->hasCompany->company->status) {
                return false;
            } else {
                return true;
            }
        } else if ($role == 'Site staff') {
            if ($user->hasCompany->company->trashed() || $user->hasCompany->company->hasCompany->company->trashed()) {
                return false;
            } else if (!$user->hasCompany->company->status || !$user->hasCompany->company->hasCompany->company->status) {
                return false;
            } else {
                return true;
            }
        } else if ($role == 'Contractor staff') {
            if ($user->hasContractor->contractor->trashed() || $user->hasContractor->contractor->hasCompany->company->trashed()) {
                return false;
            } else if (!$user->hasContractor->contractor->status || !$user->hasContractor->contractor->hasCompany->company->status) {
                return false;
            } else {
                return true;
            }
        } else {
            return false;
        }
    }

    /**
     * @param Request $request
     * @return mixed
     * @throws \Illuminate\Validation\ValidationException
     */
    public function login(Request $request)
    {
        $this->validate($request, $this->rules(), []);

        $company = [$request->email, $request->password, 'companies'];
        $contractor = [$request->email, $request->password, 'contractors'];

        if ($user = $this->authenticator->attempt(...$company)) {
            $userDetails = CompanyUser::where('email', $request->email)->first();
            $type = 'company';
            if (!$this->checkParentActivation($userDetails)) {
                return $this->makeError('Incorrect username or password !', [], 401);
            }
        } elseif ($user = $this->authenticator->attempt(...$contractor)) {
            $userDetails = ContractorUser::where('email', $request->email)->first();
            if (!$this->checkParentActivation($userDetails)) {
                return $this->makeError('Incorrect username or password !', [], 401);
            }
            $type = 'contractor';
        } else {
            return $this->makeError('Incorrect username or password !', [], 401);
        }

        if (!$userDetails->status) {
            return $this->makeError('Your account is not active !', [], 410);
        }

        $token = $user->createToken('Secret Token')->accessToken;

        $data = [
            'access_token' => $token,
            'type' => $type
        ];
        return $this->makeResponse('Login successfully.', $data, 201);
    }

    /**
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function signUp(Request $request)
    {
        $this->validate($request, [
            'email' => 'required|email',
            'password' => 'required',
            'plan' => 'required',
            'name' => 'required',
            'phone' => 'required',
            'token' => 'required'
        ]);

        $email = $request->email;
        $user = CompanyUser::where('email', $email)->first();
        if ($user) {
            return $this->makeError('Email already registered with us !', [], 410);
        }

        $user = ContractorUser::where('email', $email)->first();
        if ($user) {
            return $this->makeError('Email already registered with us !', [], 410);
        }

        $user = new CompanyUser();
        $user->email = $request->email;
        $user->status = 0;
        $user->slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $request->name)));;
        $user->password = bcrypt($request->password);
        $user->remember_token = Str::random(35);
        if ($user->save()) {
            $user->profile()->create($request->only('name', 'phone'));
            $user->assignRole('Company admin');
            try {
                $plan = SubscriptionPlan::find($request->plan);
                $user->newSubscription('main', $plan->stripe_id)->create($request->token, ['email' => $request->email]);
            } catch (\Exception $e) {
                return $this->makeError($e->getMessage(), [], 410);
            }
            $data = [
                'subject' => 'Subscription activated',
                'message' => 'You have successfully subscribed to the '.$plan->name.' plan.',
                'name' => $request->name
            ];
            $this->sendSubscriptionMail($request->email, $data);
            return $this->sendEmailVerification($user->remember_token, $user->email);
        } else {
            return $this->makeError('Something went wrong !', [], 410);
        }
    }

    /**
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function forgetPassword(Request $request)
    {
        $this->validate($request, [
            'email' => 'required|email'
        ]);

        $email = $request->email;
        $user = CompanyUser::where('email', $email)->first();
        if ($user) {
            $user->remember_token = Str::random(60);
            $user->save();
            return $this->sendResetPasswordEmail($user->remember_token, $user->email);
        }

        $user = ContractorUser::where('email', $email)->first();
        if ($user) {
            $user->remember_token = Str::random(60);
            $user->save();
            return $this->sendResetPasswordEmail($user->remember_token, $user->email);
        }

        return $this->makeError('Account not found with this email address !', [], 410);
    }

    /**
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function resetPassword(Request $request)
    {
        $this->validate($request, [
            'token' => 'required',
            'password' => 'required'
        ]);

        $token = $request->token;
        $user = CompanyUser::where('remember_token', $token)->first();
        if ($user) {
            $user->remember_token = Str::random(60);
            $user->password = bcrypt($request->password);
            $user->save();
            return $this->makeResponse('Password reset successfully.', [], 201);
        }

        $user = ContractorUser::where('remember_token', $token)->first();
        if ($user) {
            $user->remember_token = Str::random(60);
            $user->password = bcrypt($request->password);
            $user->save();
            return $this->makeResponse('Password reset successfully.', [], 201);
        }

        return $this->makeError('Invalid token !', [], 410);
    }

    /**
     * @param Request $request
     * @return \Illuminate\Http\RedirectResponse|\Illuminate\Routing\Redirector|void
     */
    public function verifyAccount(Request $request)
    {
        $token = $request->token;
        $user = CompanyUser::where('remember_token', $token)->first();
        if ($user) {
            $user->remember_token = Str::random(60);
            $user->status = 1;
            $user->save();
            return redirect(config('app.url'));
        }

        return abort(404);
    }

    /**
     * Logout user and destroy tokens
     *
     * @return array
     */
    public function logout()
    {
        $accessToken = auth()->user()->token();

        DB::table('oauth_access_tokens')->where('id', $accessToken->id)->delete();
        DB::table('oauth_refresh_tokens')->where('access_token_id', $accessToken->id)->delete();

        return $this->makeResponse('Logout successfully.', [], 200);
    }

    /**
     * Get the login validation rules.
     *
     * @return array
     */
    protected function rules()
    {
        return [
            'email' => 'required|email',
            'password' => 'required|min:6'
        ];
    }

    /**
     * @param $token
     * @param $email
     * @return array
     */
    protected function sendResetPasswordEmail($token, $email)
    {
        try {
            Mail::to($email)->send(new ResetPassword(['url' => config('app.url').'/user/reset-password/'.$token, 'subject' => 'Reset Password']));
            return $this->makeResponse('Reset password link sent to your email address.', [], 201);
        } catch (\Exception $e) {
            return $this->makeError($e->getMessage(), [], 410);
        }
    }

    /**
     * @param $token
     * @param $email
     * @return array
     */
    protected function sendEmailVerification($token, $email)
    {
        try {
            Mail::to($email)->send(new EmailVerification(['url' => route('verify.account', $token), 'subject' => 'Verify Account']));
            return $this->makeResponse('Verification link sent to your email address.', [], 201);
        } catch (\Exception $e) {
            return $this->makeError($e->getMessage(), [], 410);
        }
    }
}
