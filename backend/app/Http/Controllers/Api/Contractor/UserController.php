<?php

namespace App\Http\Controllers\Api\Contractor;

use App\Models\CompanyUser;
use App\Models\ContractorUser;
use App\Models\UserInvite;
use Carbon\Carbon;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Str;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class UserController extends Controller
{
    protected $contractor;

    /**
     * UserController constructor.
     */
    public function __construct()
    {
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
     */
    public function changePassword(Request $request)
    {
        $user = ContractorUser::find($request->user()->id);
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
        $role = $request->user()->getRoleNames()[0];
        if ($role === 'Contractor admin') {
            $companyId = $request->user()->hasCompany->company_user_id;
        } else {
            $contractorAdminId = $request->user()->hasContractor->contractor_user_id;
            $contractorAdmin = ContractorUser::with('hasCompany')->find($contractorAdminId);
            $companyId = $contractorAdmin->hasCompany->company_user_id;
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

        $check = UserInvite::where(['type' => $request->type, 'email' => $request->email, 'user_id' => $request->user()->id])->first();
        if ($check) {
            return $this->makeError('You have already invited !', [], 410);
        }

        $invite = new UserInvite();
        $invite->type = $request->type;
        $invite->user_id = $request->user()->id;
        $invite->expired_at = Carbon::now()->addDays(30);
        $invite->email = $request->email;
        $invite->slug = Str::random(60);

        if ($invite->save()) {
            $message = 'You have been invited by';
            $subject = 'Invited as staff';
            $data = [
                'name' => $request->user()->profile->name,
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
     * @param $id
     * @param Request $request
     * @return array
     */
    public function updateUserPermissions($id, Request $request)
    {
        $user = ContractorUser::find($id);
      
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

        return $this->makeResponse('User permissions updated.', ['users' => $this->contractor->getContractorStaff($request->user()->id), 'type' => $request->type], 201);
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
            'status' => 'required'
        ]);
        $user = ContractorUser::find($id);

        if (!$user) {
            return $this->makeError('Details not found !',[], 404);
        }
        $user->status = $request->status;
        $user->save();
        $user->profile()->update($request->except(['status', 'type']));
        return $this->makeResponse('User profile updated.', ['users' => $this->contractor->getContractorStaff($request->user()->id), 'type' => $request->type], 201);
    }

    /**
     * @param Request $request
     * @param $id
     * @return array
     */
    public function deleteUser(Request $request, $id)
    {
        $user = ContractorUser::find($id);

        if (!$user) {
            return $this->makeError('Details not found !',[], 404);
        }
        $user->delete();
        return $this->makeResponse('User deleted successfully.', ['users' => $this->contractor->getContractorStaff($request->user()->id), 'type' => $request->type], 201);
    }

    /**
     * @param Request $request
     * @return array
     */
    public function getContractorStaff(Request $request)
    {
        return $this->makeResponse('', ['users' => $this->contractor->getContractorStaff($request->user()->id)], 200);
    }
}
