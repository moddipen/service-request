<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CompanyHasUser extends Model
{
    public $timestamps = false;

    protected $fillable = ['company_user_id', 'user_id'];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function user()
    {
        return $this->belongsTo(CompanyUser::class, 'user_id')->withTrashed();
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function company()
    {
        return $this->belongsTo(CompanyUser::class, 'company_user_id')->withTrashed();
    }
}
