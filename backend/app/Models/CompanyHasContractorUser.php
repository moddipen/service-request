<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CompanyHasContractorUser extends Model
{
    public $timestamps = false;

    protected $fillable = ['company_user_id', 'contractor_user_id'];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function user()
    {
        return $this->belongsTo(ContractorUser::class, 'contractor_user_id')->withTrashed();
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function company()
    {
        return $this->belongsTo(CompanyUser::class, 'company_user_id')->withTrashed();
    }
}
