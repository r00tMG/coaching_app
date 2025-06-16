<?php

namespace App\Http\Controllers\Admin\Api\Coach;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\WorkingHour;

class WorkingHourController extends Controller
{
    public function index(){
        $workingHours = WorkingHour::with('user')->get();
        return response()->json([
            'message' => 'Liste des Heures de travail enregistrées',
            'data' => $workingHours
        ]);
    }
    public function store(Request $request)
    {
        logger('store working hours');
        $request->validate([
            'start_hour' => 'required|integer|min:0|max:23',
            'end_hour' => 'required|integer|min:0|max:23',
            'training_option' => 'required|string|in:Gym,At Home,Any Where,Outside',
        ]);

        $user = $request->user();
        $service = $user->services()->latest()->first();
        logger('service '. $service);

        if (!$service) {
            return response()->json([
                'message' => 'Aucun service trouvé pour cet utilisateur.'
            ], 404);
        }

        $workingHour = WorkingHour::create([
            'service_id' => $service->id,
            'start_hour' => sprintf('%02d:00:00', $request->start_hour),
            'end_hour' => sprintf('%02d:00:00', $request->end_hour),
            'training_option' => $request->training_option,
        ]);

        return response()->json([
            'message' => 'Heures de travail enregistrées',
            'data' => $workingHour
        ]);
    }
}
