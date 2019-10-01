<?php

namespace App\Http\Controllers\Api\Company;

use App\Models\CompanyUser;
use App\Models\ContractorUser;
use App\Models\UserInvite;
use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Str;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use Auth;

class UserController extends Controller
{
    protected $company, $contractor;

    /**
     * UserController constructor.
     */
    public function __construct()
    {
        $this->company = new CompanyUser();
        $this->contractor = new ContractorUser();
    }

    /**
     * @param Request
     * @return array$request
     */
    public function getAuthUserDetails(Request $request)
    {
        $data = [
            'profile' => $this->getAuthProfile($request),
            'role' => $request->user()->getRoleNames()[0],
            'permissions' => $request->user()->getAllPermissions()->pluck('name')
        ];
        return $this->makeResponse('User loaded .', $data, 200);
    }

    /**
     * @param Request $request
     * @return mixed
     */
    public function getAuthProfile(Request $request)
    {
        $profile = $request->user()->profile;
        $profile->photo = $profile->photo ? url('storage/app/'.$profile->photo) : '';
        $profile->email = $request->user()->email;
        return $profile;
    }

    /**
     * @param Request $request
     * @return array
     */
    public function update(Request $request)
    {
        if ($request->hasFile('photo')) {
            $path = $request->photo->store('images');
            $request->user()->profile()->update(['photo' => $path]);
            $request->user()->profile()->update($request->except(['photo']));
        } else {
            $request->user()->profile()->update($request->all());
        }
        $data = [
            'profile' => $this->getAuthProfile($request),
        ];
        return $this->makeResponse('User profile updated.', $data, 201);
    }

    /**
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function changePassword(Request $request)
    {
        $this->validate($request, [
            'password' => 'required'
        ]);
        $user = CompanyUser::find($request->user()->id);
        $user->password = bcrypt($request->password);
        if ($user->save()) {
            return $this->makeResponse('Password changed successfully.', [], 201);
        } else {
            return $this->makeError('Oops, something went wrong !',[], 401);
        }
    }

    /**
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function inviteUser(Request $request)
    {   
        $authId = $request->user()->id;
        $role = $request->user()->getRoleNames()[0];
        if ($role === 'Company admin') {
            $companyId = $authId;
        } else if ($role === 'Site admin' || $role === 'Company editor') {
            $companyId = $request->user()->hasCompany->company_user_id;
        } else {
            $siteAdminId = $request->user()->hasCompany->company_user_id;
            $siteAdmin = CompanyUser::with('hasCompany')->find($siteAdminId);
            $companyId = $siteAdmin->hasCompany->company_user_id;
        }
        if (!$this->checkSubscriptionsLimits($companyId, 'users')) {
            return $this->makeError('Limit exceeded !', [], 401);
        }

        $this->validate($request, [
            'type' => 'required',
            'email' => 'required|email'
        ]);

        $email = $request->email;
        $user = CompanyUser::where('email', $email)->first();
        if ($user) {
            return $this->makeError('Email already registered !', [], 410);
        }

        $user = ContractorUser::where('email', $email)->first();
        if ($user) {
            return $this->makeError('Email already registered !', [], 410);
        }

        $invite = new UserInvite();
        $invite->type = $request->type;
        $invite->user_id = $request->user()->id;
        $invite->expired_at = Carbon::now()->addDays(30);
        $invite->email = $request->email;
        $invite->slug = Str::random(60);

        if ($invite->save()) {
            $message = 'You have been invited by';
            // if ($invite->type == 0) {
            //     $subject = 'Invited as company editor';
            // } else if ($invite->type == 1) {
            //     $subject = 'Invited as contractor admin';
            // } else if ($invite->type == 3) {
            //     $subject = 'Invited as site admin';
            // } else if ($invite->type == 4) {
            //     $subject = 'Invited as site staff';
            // } else {
            //     $message = '';
            //     $subject = '';
            // }
            $name = $request->user()->profile->name;
            $subject = "Sign up to ".$name." Service Requests";
            $data = [
                'name' => $name,
                'email' => $request->user()->email,
                'message' => $message,
                'subject' => $subject,
                'url' => config('app.url').'/user/set-account/'.$invite->slug
            ];
            $this->sendInviteMail($request->email, $data);
            return $this->makeResponse('Invited successfully.', [], 201);
        } else {
            return $this->makeError('Oops, something went wrong !',[], 401);
        }
    }

    /**
     * @param Request $request
     * @return array
     */
    public function getCompanyEditors(Request $request)
    {
        return $this->makeResponse('', ['users' => $this->company->getEditors($request->user()->id)], 200);
    }

    /**
     * @param Request $request
     * @return array
     */
    public function getContractors(Request $request)
    {
        return $this->makeResponse('', ['users' => $this->contractor->getContractors($request->user()->id)], 200);
    }

    /**
     * @param Request $request
     * @return array
     */
    public function getSiteAdmin(Request $request)
    {
        return $this->makeResponse('', ['users' => $this->company->getSiteAdmins($request->user()->id)], 200);
    }

    /**
     * @param Request $request
     * @return array
     */
    public function getSiteStaff(Request $request)
    {
        return $this->makeResponse('', ['users' => $this->company->getSiteStaff($request->user()->id)], 200);
    }

    /**
     * @param $id
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function updateUserPermissions($id, Request $request)
    {
        $this->validate($request, [
            'type' => 'required'
        ]);

        if ($request->type == 'contractor') {
            $user = ContractorUser::find($id);
        } else {
            $user = CompanyUser::find($id);
        }
        if (!$user) {
            return $this->makeError('Details not found !',[], 404);
        }
        $permissions = Permission::all();
        foreach($permissions as $permission) {
            if ($user->hasPermissionTo($permission)) {
                $user->revokePermissionTo($permission);
            }
        }
        foreach($request->permissions as $val) {
            $user->givePermissionTo(Permission::find($val));
        }

        return $this->makeResponse('User permissions updated.', ['users' => $this->getAllUsers($request->type, $request), 'type' => $request->type], 201);
    }

    /**
     * @return array
     */
    public function rolesAndPermissions()
    {
        $roles = Role::with('permissions')->where('name', '!=', 'Super Admin')->get();
        foreach ($roles as $role) {
            $perm = [];
            foreach ($role->permissions as $permission) {
                $perm[] = $permission->name;
            }
            $role->permission = $perm;
            unset($role->permissions);
        }
        $permissions = Permission::select('name','id')->get();
        return $this->makeResponse('', ['roles' => $roles, 'permissions' => $permissions], 200);
    }

    /**
     * @param Request $request
     * @param $id
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function updateUser(Request $request, $id)
    {
        $this->validate($request, [
            'type' => 'required',
            'status' => 'required'
        ]);

        if ($request->type == 'contractor') {
            $user = ContractorUser::find($id);
        } else {
            $user = CompanyUser::find($id);
        }
        if (!$user) {
            return $this->makeError('Details not found !',[], 404);
        }
        $user->status = $request->status;
        $user->save();
        $user->profile()->update($request->except(['type', 'status']));
        return $this->makeResponse('User profile updated.', ['users' => $this->getAllUsers($request->type, $request), 'type' => $request->type], 201);
    }

    /**
     * @param Request $request
     * @param $id
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function deleteUser(Request $request, $id)
    {
        $this->validate($request, [
            'type' => 'required',
        ]);
        if ($request->type == 'contractor') {
            $user = ContractorUser::find($id);
        } else {
            $user = CompanyUser::find($id);
        }

        if (!$user) {
            return $this->makeError('Details not found !',[], 404);
        }
        $user->delete();
        return $this->makeResponse('User deleted successfully.', ['users' => $this->getAllUsers($request->type, $request), 'type' => $request->type], 201);
    }

    /**
     * @param $type
     * @return CompanyUser[]|\Illuminate\Database\Eloquent\Builder[]|\Illuminate\Database\Eloquent\Collection|mixed
     */
    private function getAllUsers($type, $request)
    {
        $users = [];
        if($type == 'contractor') {
            $users = $this->contractor->getContractors($request->user()->id);
        } else if ($type == 'editor') {
            $users = $this->company->getEditors($request->user()->id);
        } else if ($type == 'site-admin') {
            $users = $this->company->getSiteAdmins($request->user()->id);
        } else if ($type == 'site-staff') {
            $users = $this->company->getSiteStaff($request->user()->id);
        }
        return $users;
    }
}
