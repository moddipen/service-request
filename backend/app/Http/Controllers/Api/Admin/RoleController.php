<?php

namespace App\Http\Controllers\Api\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RoleController extends Controller
{
    /**
     * @return array
     */
    public function index()
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
     * @param $id
     * @return array
     */
    public function edit($id)
    {
        $role = Role::find($id);
        if ($role) {
            $rolePermissions = [];
            $permissions = Permission::all();
            foreach ($permissions as  $permission) {
                if ($role->hasPermissionTo($permission->name)) {
                    $rolePermissions[] = $permission->id;
                }
            }
            $role->permissions = $rolePermissions;
            return $this->makeResponse('', ['role' => $role, 'permissions' => $permissions], 200);
        } else {
            return $this->makeError('Role not found !', [], 401);
        }
    }

    /**
     * @param $id
     * @param Request $request
     * @return array
     * @throws \Illuminate\Validation\ValidationException
     */
    public function update($id, Request $request)
    {
        $role = Role::find($id);
        if ($role) {
            $permissions = Permission::all();
            foreach($permissions as $permission) {
                if ($role->hasPermissionTo($permission)) {
                    $role->revokePermissionTo($permission);
                }
            }

            foreach($request->permissions as $val) {
                $role->givePermissionTo(Permission::find($val));
            }
            $roles = Role::with('permissions')->where('name', '!=', 'Super Admin')->get();
            foreach ($roles as $role) {
                $perm = [];
                foreach ($role->permissions as $permission) {
                    $perm[] = $permission->name;
                }
                $role->permission = $perm;
                unset($role->permissions);
            }

            return $this->makeResponse('Role updated.', [ 'roles' => $roles ], 201);
        } else {
            return $this->makeError('Role not found !', [], 401);
        }
    }
}
