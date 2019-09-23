<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class WorkTaskComment extends Model
{
    protected $fillable= ['work_task_id', 'message'];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function creator()
    {
        return $this->morphTo('added_by')->withTrashed();
    }
}
