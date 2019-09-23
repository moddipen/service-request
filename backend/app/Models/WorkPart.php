<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class WorkPart extends Model
{
    protected $fillable= ['work_order_id', 'name', 'price'];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function creator()
    {
        return $this->morphTo('added_by')->withTrashed();
    }
}
