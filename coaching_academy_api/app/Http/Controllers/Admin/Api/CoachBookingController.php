<?php

namespace App\Http\Controllers\Admin\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Booking;

class CoachBookingController extends Controller
{
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
