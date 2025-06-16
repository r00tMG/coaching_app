<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;
use App\Models\Service;

class WorkingHour extends Model
{
    use HasFactory;
    protected $fillable = [
        "service_id",
        'start_hour',
        'end_hour',
        'training_option',
    ];

    public function service()
    {
        return $this->belongsTo(Service::class);
    }


   /*  public function user()
    {
        return $this->belongsTo(User::class);
    } */
}
