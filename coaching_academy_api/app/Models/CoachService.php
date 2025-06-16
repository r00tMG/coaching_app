<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
use App\Models\Service;
class CoachService extends Model
{
    use HasFactory;
    protected $fillable = [
        'name',
        'duration', 
        'price', 'service_id'
    ];


    public function service()
    {
        return $this->belongsTo(Service::class);
    }
}
