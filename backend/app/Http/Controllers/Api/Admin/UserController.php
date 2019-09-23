<?php

namespace App\Http\Controllers\Api\Admin;

use App\Models\CompanyUser;
use App\Models\ContractorUser;
use App\Models\Setting;
use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Spatie\Permission\Models\Permission;

class UserController extends Controller
{
    protected $company, $contractor;

    public function __construct()
    {
        $this->company = new CompanyUser();
        $this->contractor = new ContractorUser();
    }

    /**
     * @param Request $request
     * @return array
     */
    public function getAuthUserDetails(Request $request)
    {
        $data = [
            'profile' => $request->user(),
            'role' => $request->user()->getRoleNames()[0],
            'permissions' => $request->user()->getAllPermissions()->pluck('name')
        ];
        return $this->makeResponse('User loaded .', $data, 200);
    }

    /**
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function updateSettings(Request $request)
    {
        $this->validate($request, [
            'name' => 'required',
            'value' => 'required'
        ]);

        Setting::updateOrCreate(['name' => $request->name], ['value' => $request->value]);
        return $this->makeResponse('Setting updated .', [], 201);
    }

    /**
     * @return array
     */
    public function companyUsers()
    {
        return $this->makeResponse('', ['companies' => $this->company->getCompanies()], 200);
    }

    /**
     * @param Request $request
     * @return array
     */
    public function getChildUsers(Request $request)
    {
        $users = [];
        $type = $request->type;
        if($type == 'contractors') {
            $users = $this->contractor->getContractors($request->id);
        } else if ($type == 'editors') {
            $users = $this->company->getEditors($request->id);
        } else if ($type == 'site-admins') {
            $users = $this->company->getSiteAdmins($request->id);
        } else if ($type == 'site-staff') {
            $users = $this->company->getSiteStaff($request->id);
        } else if ($type == 'contractor-staff') {
            $users = $this->contractor->getContractorStaff($request->id);
        }
        return $this->makeResponse('', ['users' => $users, 'type' => $type, 'id' => $request->id], 200);
    }

    /**
     * @param Request $request
     * @return array
     */
    public function changePassword(Request $request)
    {
        $user = User::find($request->user()->id);
        $user->password = bcrypt($request->password);
        if ($user->save()) {
            return $this->makeResponse('Password changed successfully.', [], 201);
        } else {
            return $this->makeError('Oops, something went wrong !',[], 401);
        }
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
            'pid' => 'required',
            'status' => 'required'
        ]);

        if ($request->type == 'contractors' || $request->type == 'contractor-staff') {
            $user = ContractorUser::find($id);
        } else {
            $user = CompanyUser::find($id);
        }
        if (!$user) {
            return $this->makeError('Details not found !',[], 404);
        }
        $user->status = $request->status;
        $user->save();
        $user->profile()->update($request->except(['type', 'status', 'pid']));
        return $this->makeResponse('User details updated.', ['users' => $this->getAllUsers($request->type, $request->pid), 'type' => $request->type, 'pid' => $request->pid], 201);
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
            'type' => 'required',
            'pid' => 'required'
        ]);

        if ($request->type == 'contractors' || $request->type == 'contractor-staff') {
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

        return $this->makeResponse('User permissions updated.', ['users' => $this->getAllUsers($request->type, $request->pid), 'type' => $request->type, 'pid' => $request->pid], 201);
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
            'pid' => 'required'
        ]);
        if ($request->type == 'contractors' || $request->type == 'contractor-staff') {
            $user = ContractorUser::find($id);
        } else {
            $user = CompanyUser::find($id);
        }

        if (!$user) {
            return $this->makeError('Details not found !',[], 404);
        }
        $user->delete();
        return $this->makeResponse('User deleted successfully.', ['users' => $this->getAllUsers($request->type, $request->pid), 'type' => $request->type], 201);
    }

    /**
     * @param $type
     * @return CompanyUser[]|\Illuminate\Database\Eloquent\Builder[]|\Illuminate\Database\Eloquent\Collection|mixed
     */
    private function getAllUsers($type, $id)
    {
        $users = [];
        if ($type == 'companies') {
            $users = $this->company->getCompanies();
        } else if($type == 'contractors') {
            $users = $this->contractor->getContractors($id);
        } else if ($type == 'editors') {
            $users = $this->company->getEditors($id);
        } else if ($type == 'site-admins') {
            $users = $this->company->getSiteAdmins($id);
        } else if ($type == 'site-staff') {
            $users = $this->company->getSiteStaff($id);
        } else if ($type == 'site-staff') {
            $users = $this->contractor->getContractorStaff($id);
        }
        return $users;
    }
}
