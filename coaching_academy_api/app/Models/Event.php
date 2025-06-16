<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\User;

class Event extends Model
{
    use HasFactory;
    protected $fillable = [
        'title',
        'description',
        'start_time',
        'end_time',
        'image_url',
        'coach_id',
    ];

    protected $dates = [
        'start_time',
        'end_time',
    ];
    protected $casts = [
        'start_time' => 'datetime',
        'end_time' => 'datetime',
    ];
    

    public function coach()
    {
        return $this->belongsTo(User::class, 'coach_id');
    }
}
