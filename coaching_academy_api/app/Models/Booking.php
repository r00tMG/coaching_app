<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Booking extends Model
{
    use HasFactory;
    protected $fillable = [
        'sporty_id', 'coach_id', 'coach_service_id', 'date', 'time', 'gender', 'training_place', 'status',
    ];

    public function service()
    {
        return $this->belongsTo(CoachService::class, 'coach_service_id');
    }

    public function coach()
    {
        return $this->belongsTo(User::class, 'coach_id');
    }

    public function sporty()
    {
        return $this->belongsTo(User::class, 'sporty_id');
    }
}
