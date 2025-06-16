<?php

namespace App\Http\Controllers\Admin\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Event;

class EventController extends Controller
{
    public function index(Request $request)
    {
        logger('eventcontroller');
        $date = $request->query('date');

        if (!$date) {
            return response()->json(['error' => 'Date is required'], 400);
        }

        $events = Event::whereDate('start_time', $date)
            ->get()
            ->map(function ($event) {
                return [
                    'date' => $event->start_time->format('l, d M, Y'),
                    //'date' => \Carbon\Carbon::parse($event->start_time)->format('l, d M, Y'),
                    'time' => 'From ' . $event->start_time->format('h:iA') . ' to ' . $event->end_time->format('h:iA'),
                    'title' => $event->title,
                    'description' => $event->description,
                    'image' => $event->image_url,
                ];
            });

        return response()->json($events);
    }
}

