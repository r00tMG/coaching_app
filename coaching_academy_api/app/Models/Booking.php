<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Booking extends Model
{
    use HasFactory;
    protected $fillable = [
        'coach_id',
        'user_id',
        'service_name',
        'price',
        'status',
        'booking_time',
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function coach()
    {
        return $this->belongsTo(User::class, 'coach_id');
    }
}
