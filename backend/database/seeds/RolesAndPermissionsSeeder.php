<?php

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RolesAndPermissionsSeeder extends Seeder
{
    /**
     * Permissions
     *
     * @var array
     */
    protected $permissions = [
        'user create',
        'user edit',
        'user delete',
        'user list',
        'dashboard'
    ];

    /**
     * Roles
     *
     * @var array
     */
    protected $roles = [
      'Super admin',
      'Company admin',
      'Company editor',
      'Contractor admin',
      'Contractor staff',
      'Site admin',
      'Site staff'
    ];

    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Reset cached roles and permissions
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();

        foreach ($this->permissions as $permission) {
            Permission::create(['name' => $permission]);
        }

        foreach ($this->roles as $role) {
            $role = Role::create(['name' => $role]);
            if ($role == 'Super admin') {
                $role->givePermissionTo(Permission::all());
            }
        }
    }
}
