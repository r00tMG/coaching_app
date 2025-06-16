<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
use App\Models\WorkingHour;
use App\Models\WorkspaceMedia;
use App\Models\CoachService;

class Service extends Model
{
    use HasFactory;
    
    protected $fillable = [
        'user_id',
        'service_name',
        'category',
        'description',
        
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function workingHours()
    {
        return $this->hasMany(WorkingHour::class);
    }

    public function workspaceMedias()
    {
        return $this->hasMany(WorkspaceMedia::class);
    }

    public function coachServices()
    {
        return $this->hasMany(CoachService::class);
    }


}
