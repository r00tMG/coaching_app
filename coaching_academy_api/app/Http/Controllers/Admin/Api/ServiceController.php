<?php

namespace App\Http\Controllers\Admin\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Service;
use App\Models\CoachService;
use Illuminate\Support\Facades\Auth;

class ServiceController extends Controller
{
    public function indexServiceWithWorkingHours()
    {
        logger('fgh,;');
        $coachId = Auth::id();
        $services = Service::where('user_id', $coachId)->with(['workingHours', 'workspaceMedias', 'user', 'coachServices'])->get();

        return response()->json([
            'services' => $services
        ]);
    }

    public function index()
    {
        $coachId = Auth::id();
        $services = Service::with(['workingHours', 'workspaceMedias', 'user', 'coachServices'])->get();

        return response()->json([
            'services' => $services
        ]);
    }

    public function show($id)
    {
        /* $service = CoachService::where('id', $id)
            ->where('user_id', Auth::id())
            ->first(); */
        $service = CoachService::join('services', 'coach_services.service_id', '=', 'services.id')
            ->where('coach_services.id', $id)
            ->where('services.user_id', Auth::id())
            ->select('coach_services.*')
            ->first();
        
        if (!$service) {
            return response()->json(['message' => 'Service non trouvé.'], 404);
        }

        return response()->json([
            'service' => $service
        ]);
    }

    public function update(Request $request, $id)
    {
        logger('update');
        logger($request->all());
        $request->validate([
            'name'     => 'required|string|max:255',
            'duration' => 'required|integer|min:1',
            'price'    => 'required|numeric|min:0',
        ]);

        /* $service = CoachService::where('id', $id)
            ->where('user_id', Auth::id())
            ->first(); */
        $service = CoachService::join('services', 'coach_services.service_id', '=', 'services.id')
            ->where('coach_services.id', $id)
            ->where('services.user_id', Auth::id())
            ->select('coach_services.*')
            ->first();
        

        if (!$service) {
            return response()->json(['message' => 'Service non trouvé.'], 404);
        }

        $service->update([
            'name'     => $request->name,
            'duration' => $request->duration,
            'price'    => $request->price,
        ]);

        return response()->json([
            'message' => 'Service mis à jour avec succès.',
            'service' => $service
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'service_name' => 'required|string|max:255',
            'category' => 'required|string|max:255',
            'description' => 'nullable|string',
        ]);

        $service = Service::create([
            'user_id' => auth()->id(),
            'service_name' => $validated['service_name'],
            'category' => $validated['category'],
            'description' => $validated['description'] ?? null,
        ]);

        return response()->json([
            'message' => 'Service registered successfully',
            'service' => $service,
        ]);
    }

    public function storeCoachServiceDetails(Request $request)
    {
        logger('test');
        $request->validate([
            'name' => 'required|string|max:255',
            'duration' => 'required|string|max:50',
            'price' => 'required|numeric|min:0',
        ]);
        $user = $request->user();
        $service = $user->services()->latest()->first();
        $service = CoachService::create([
            'service_id' => $service->id,
            'name' => $request->name,
            'duration' => $request->duration,
            'price' => $request->price,
        ]);

        return response()->json([
            "status"=>true, 
            'message' => 'Service enregistré avec succès',
            'service' => $service
        ], 201);
    }

    

}
