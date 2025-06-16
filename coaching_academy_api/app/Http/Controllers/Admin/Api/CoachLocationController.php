<?php

namespace App\Http\Controllers\Admin\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\WorkspaceMedia;

class CoachLocationController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'location' => 'required|string|max:255',
            'address' => 'nullable|string',
            'latitude' => 'nullable|numeric',
            'longitude' => 'nullable|numeric',
        ]);

        $user = Auth::user();

        $user->update([
            'location' => $request->location,
            'address' => $request->address,
            'latitude' => $request->latitude,
            'longitude' => $request->longitude,
        ]);

        return response()->json([
            'message' => 'Location saved successfully.',
            'user' => $user
        ], 200);
    }

    public function uploadWorkspace(Request $request)
    {
        
        logger($request->all());
        $request->validate([
            'image' => 'required|file|mimes:jpeg,png,jpg,gif,webp',
            'video' => 'required|file|mimes:mp4,mov,avi,wmv,mkv',
        ]);
        $user = $request->user();
        $service = $user->services()->latest()->first();
        $uploadedPaths = [];

        // Upload image
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('workspace_uploads/images', 'public');
            $uploadedPaths['image'] = asset("storage/$imagePath");
        }

        // Upload video
        if ($request->hasFile('video')) {
            $videoPath = $request->file('video')->store('workspace_uploads/videos', 'public');
            $uploadedPaths['video'] = asset("storage/$videoPath");
        }

        if (!$service) {
            return response()->json([
                'message' => 'Aucun service trouvé pour cet utilisateur.'
            ], 404);
        }

        $workspaceMedia = WorkspaceMedia::create([
            'service_id' => $service->id,
            'workspace_image' => $imagePath,
            'workspace_video' => $videoPath,
        ]);
        // Sauvegarde optionnelle dans la base
        //$user->workspace_media = $imagePath ?? null;
        //$user->workspace_video = $videoPath ?? null;
        //$user->save();

        return response()->json([
            'message' => 'Upload réussi',
            'files' => $uploadedPaths,
            'data' => $workspaceMedia
        ], 201);
    }


}
