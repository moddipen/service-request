<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class WorkTask extends Model
{
    protected $fillable= ['work_order_id', 'title', 'description', 'work_category_id', 'work_priority_id', 'company_notes', 'contractor_notes'];
    protected $appends = ['images'];

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function category()
    {
        return $this->belongsTo(WorkCategory::class, 'work_category_id')->select('name');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function priority()
    {
        return $this->belongsTo(WorkPriority::class, 'work_priority_id')->select('name', 'description');
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function creator()
    {
        return $this->morphTo('added_by')->withTrashed();
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function comments()
    {
        return $this->hasMany(WorkTaskComment::class, 'work_task_id');
    }

    /**
     * @return array
     */
    public function getImagesAttribute()
    {
        $images = TaskImage::where('work_task_id', $this->attributes['id'])->select('path')->get();
        $paths = [];
        foreach ($images as $image) {
            $paths[] =  url('storage/app/'.$image->path);
        }
        return $paths;
    }
}
