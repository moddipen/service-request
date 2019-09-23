<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserProfile extends Model
{
    protected $fillable = ['address', 'photo', 'company_name', 'website', 'phone', 'name'];
}
