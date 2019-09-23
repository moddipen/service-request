<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ContractorHasUser extends Model
{
    public $timestamps = false;

    protected $fillable = ['contractor_user_id', 'user_id'];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function user()
    {
        return $this->belongsTo(ContractorUser::class, 'user_id')->withTrashed();
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function contractor()
    {
        return $this->belongsTo(ContractorUser::class, 'contractor_user_id')->withTrashed();
    }
}
