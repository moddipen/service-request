<?php

namespace App\Http\Controllers\Api\Auth;

use App\Mail\WorkOrder;
use App\Models\Authenticator;
use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;

class AdminController extends Controller
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
     * @param Request $request
     * @return mixed
     * @throws \Illuminate\Validation\ValidationException
     */
    public function login(Request $request)
    {
        $this->validate($request, $this->rules(), $this->validationErrorMessages());

        $admin = [$request->email, $request->password, 'users'];

        if ($user = $this->authenticator->attempt(...$admin)) {
            User::where('email', $request->email)->first();
        }  else {
            return $this->makeError('Incorrect username or password !', [], 401);
        }

        $token = $user->createToken('Secret Token')->accessToken;

        $data = [
            'access_token' => $token,
            'type' => 'admin'
        ];
        return $this->makeResponse('Login successfully.', $data, 201);
    }

    /**
     * Logout admin and destroy tokens
     *
     * @return array
     */
    public function logout()
    {
        $accessToken = auth()->user()->token();

        DB::table('oauth_access_tokens')->where('id', $accessToken->id)->delete();
        DB::table('oauth_refresh_tokens')->where('access_token_id', $accessToken->id)->delete();

        return $this->makeResponse('', [], 200);
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
     * Get the login validation error messages.
     *
     * @return array
     */
    protected function validationErrorMessages()
    {
        return [];
    }

    public function testMail()
    {
        Mail::to('admin1@yopmail.com')->send(new WorkOrder());
    }
}
