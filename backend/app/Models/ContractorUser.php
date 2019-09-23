<?php

namespace App\Models;

use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Foundation\Auth\User as Authenticatable;
use SMartins\PassportMultiauth\HasMultiAuthApiTokens;
use Spatie\Permission\Traits\HasRoles;

class ContractorUser extends Authenticatable
{
    use HasMultiAuthApiTokens, HasRoles, SoftDeletes;

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
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function hasCompany()
    {
        return $this->hasOne(CompanyHasContractorUser::class, 'contractor_user_id');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function hasContractor()
    {
        return $this->hasOne(ContractorHasUser::class, 'user_id');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function hasUsers()
    {
        return $this->hasMany(ContractorHasUser::class, 'contractor_user_id');
    }

    /**
     * @param $request
     * @return mixed
     */
    public function getContractors($id)
    {
        $users = ContractorUser::with('hasCompany', 'profile')
            ->whereHas('hasCompany', function ($query) use ($id) {
                return $query->where('company_user_id', '=', $id);
            })->role('Contractor admin')->get();
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
    public function getContractorStaff($id)
    {
        $users = ContractorUser::with('hasContractor', 'profile')
            ->whereHas('hasContractor', function ($query) use ($id) {
                return $query->where('contractor_user_id', '=', $id);
            })->role('Contractor staff')->get();
        foreach ($users as &$user) {
            $user->permission = $user->getAllPermissions()->pluck('name');
            $user->pid = $id;
        }
        return $users;
    }
}
