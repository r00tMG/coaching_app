<?php

namespace App\Http\Controllers\Admin\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Booking;

class CoachBookingController extends Controller
{
    // app/Http/Controllers/API/BookingController.php
    public function store(Request $request)
    {
        $request->validate([
            'coach_id' => 'required|exists:users,id',
            'coach_service_id' => 'required|exists:coach_services,id',
            'date' => 'required|date',
            'time' => 'required|string',
            'gender' => 'required|string',
            'training_place' => 'required|string',
        ]);

        $booking = Booking::create([
            'sporty_id' => auth()->id(),
            'coach_id' => $request->coach_id,
            'coach_service_id' => $request->coach_service_id,
            'date' => $request->date,
            'time' => $request->time,
            'gender' => $request->gender,
            'training_place' => $request->training_place,
            'status' => 'pending',
        ]);

        return response()->json(['message' => 'Booking created', 'booking' => $booking], 201);
    }

    public function index(Request $request)
    {
        $coachId = auth()->id();

        $bookings = Booking::where('coach_id', $coachId)
            ->with('user')
            ->get()
            ->groupBy(function ($item) {
                return $item->status === 'pending' ? 'new' : 'past';
            });

        return response()->json($bookings);
    }

    public function show($id)
    {
        $booking = Booking::with('user')->findOrFail($id);

        return response()->json($booking);
    }
}
