<?php

namespace App\Http\Controllers\Api;

use App\Models\CompanyHasContractorUser;
use App\Models\CompanyHasUser;
use App\Models\CompanyUser;
use App\Models\ContractorHasUser;
use App\Models\ContractorUser;
use App\Models\Setting;
use App\Models\SubscriptionPlan;
use App\Models\UserInvite;
use App\Models\WorkPriority;
use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Str;

class GeneralController extends Controller
{
    /**
     * @return array
     */
    public function getSubscriptionPlan()
    {
        $plans = SubscriptionPlan::all();
        return $this->makeResponse('', ['plans' => $plans], 200);
    }

    /**
     * @return array
     */
    public function getSettings()
    {
        $settings = Setting::select('id', 'value', 'name')->get();
        $plans = SubscriptionPlan::all();
        $priority = WorkPriority::all();
        $constants = [
            'stripe' => config('services.stripe.key')
        ];
        return $this->makeResponse('', ['priority' => $priority, 'settings' => $settings, 'plans' => $plans, 'constants' => $constants], 200);
    }

    /**
     * @return array
     */
    public function getWorkPriorities()
    {
        $priorities = WorkPriority::all();
        return $this->makeResponse('', ['priorities' => $priorities], 200);
    }

    /**
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function setAccountPassword(Request $request)
    {
        $this->validate($request, [
            'token' => 'required',
            'password' => 'required',
            'name' => 'required',
            'phone' => 'required'
        ]);

        $invite = UserInvite::where('slug', $request->token)->first();
        if (!$invite) {
            return $this->makeError('Oops, record not found !', [], 401);
        }
        if ($invite->expired_at < Carbon::now()) {
            return $this->makeError('Oops, invitation is expired !', [], 401);
        }
        $user = CompanyUser::where('email', $invite->email)->first();
        if ($user) {
            return $this->makeError('Email already registered with us please login!', [], 410);
        }
        $contractor = ContractorUser::where('email', $invite->email)->first();
        if ($invite->type == 0) {
            $user = new CompanyUser();
            $user->email = $invite->email;
            $user->status = 1;
            $user->slug = '';
            $user->password = bcrypt($request->password);
            $user->save();
            $user->assignRole('Company editor');
            CompanyHasUser::create(['company_user_id' => $invite->user_id, 'user_id' => $user->id]);
        } else if ($invite->type == 1) {
            if ($contractor) {
                CompanyHasContractorUser::create(['company_user_id' => $invite->user_id, 'contractor_user_id' => $contractor->id]);
            } else {
                $user = new ContractorUser();
                $user->email = $invite->email;
                $user->status = 1;
                $user->password = bcrypt($request->password);
                $user->save();
                $user->assignRole('Contractor admin');
                CompanyHasContractorUser::create(['company_user_id' => $invite->user_id, 'contractor_user_id' => $user->id]);
            }
        } else if ($invite->type == 2) {
            if ($contractor) {
                ContractorHasUser::create(['contractor_user_id' => $invite->user_id, 'user_id' => $contractor->id]);
            } else {
                $user = new ContractorUser();
                $user->email = $invite->email;
                $user->status = 1;
                $user->password = bcrypt($request->password);
                $user->save();
                $user->assignRole('Contractor staff');
                ContractorHasUser::create(['contractor_user_id' => $invite->user_id, 'user_id' => $user->id]);
            }
        } else if ($invite->type == 3) {
            $user = new CompanyUser();
            $user->email = $invite->email;
            $user->status = 1;
            $user->slug = '';
            $user->password = bcrypt($request->password);
            $user->save();
            $user->assignRole('Site admin');
            CompanyHasUser::create(['company_user_id' => $invite->user_id, 'user_id' => $user->id]);
        } else {
            $user = new CompanyUser();
            $user->email = $invite->email;
            $user->status = 1;
            $user->slug = '';
            $user->password = bcrypt($request->password);
            $user->save();
            $user->assignRole('Site staff');
            CompanyHasUser::create(['company_user_id' => $invite->user_id, 'user_id' => $user->id]);
        }
        $user->profile()->create(['name' => $request->name, 'phone' => $request->phone]);
        $invite->slug = Str::random(60);
        $invite->save();
        return $this->makeResponse('Your account configured...', [], 201);
    }
}
