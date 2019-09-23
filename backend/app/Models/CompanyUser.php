<?php

namespace App\Models;

use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use SMartins\PassportMultiauth\HasMultiAuthApiTokens;
use Spatie\Permission\Traits\HasRoles;
use Laravel\Cashier\Billable;

class CompanyUser extends Authenticatable
{
    use HasMultiAuthApiTokens, HasRoles, Billable, SoftDeletes;

    /**
     * Auth guard
     *
     * @var string
     */
    protected $guard_name = 'web';

    /**
     * @return \Illuminate\Database\Eloquent\Relations\MorphOne
     */
    public function profile()
    {
        return $this->morphOne(UserProfile::class, 'user');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\MorphMany
     */
    public function orders()
    {
        return $this->morphMany(WorkOrder::class, 'order_by');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\MorphMany
     */
    public function tasks()
    {
        return $this->morphMany(WorkTask::class, 'added_by');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\MorphMany
     */
    public function comments()
    {
        return $this->morphMany(WorkTaskComment::class, 'added_by');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\MorphMany
     */
    public function parts()
    {
        return $this->morphMany(WorkPart::class, 'added_by');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function hasUsers()
    {
        return $this->hasMany(CompanyHasUser::class, 'company_user_id');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function hasContractors()
    {
        return $this->hasMany(CompanyHasContractorUser::class, 'company_user_id');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function hasCompany()
    {
        return $this->hasOne(CompanyHasUser::class, 'user_id');
    }

    /**
     * @return mixed
     */
    public function getCompanies()
    {
        $users = CompanyUser::with('profile')->role('Company admin')->get();
        foreach ($users as &$user) {
            $user->permission = $user->getAllPermissions()->pluck('name');
        }
        return $users;
    }

    /**
     * @param $request
     * @return CompanyUser[]|\Illuminate\Database\Eloquent\Builder[]|\Illuminate\Database\Eloquent\Collection
     */
    public function getEditors($id)
    {
        $users = CompanyUser::with('hasCompany', 'profile')
            ->whereHas('hasCompany', function ($query) use ($id) {
                return $query->where('company_user_id', '=', $id);
            })->role('Company editor')->get();
        foreach ($users as &$user) {
            $user->permission = $user->getAllPermissions()->pluck('name');
            $user->pid = $id;
        }
        return $users;
    }

    /**
     * @param $request
     * @return mixed
     */
    public function getSiteAdmins($id)
    {
        $users = CompanyUser::with('hasCompany', 'profile')
            ->whereHas('hasCompany', function ($query) use ($id) {
                return $query->where('company_user_id', '=', $id);
            })->role('Site admin')->get();
        foreach ($users as &$user) {
            $user->permission = $user->getAllPermissions()->pluck('name');
            $user->pid = $id;
        }
        return $users;
    }

    /**
     * @param $request
     * @return mixed
     */
    public function getSiteStaff($id)
    {
        $users = CompanyUser::with('hasCompany', 'profile')
            ->whereHas('hasCompany', function ($query) use ($id) {
                return $query->where('company_user_id', '=', $id);
            })->role('Site staff')->get();
        foreach ($users as &$user) {
            $user->permission = $user->getAllPermissions()->pluck('name');
            $user->pid = $id;
        }
        return $users;
    }
}
