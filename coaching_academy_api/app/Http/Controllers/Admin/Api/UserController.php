<?php

namespace App\Http\Controllers\Admin\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Validator;
use App\Models\User;
use Hash;
use Illuminate\Support\Facades\Storage;


class UserController extends Controller
{
    public function initialSignup(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name'     => 'required|string|max:255',
            'email'    => 'required|string|email|max:255|unique:users',
            'country'  => 'required|string|max:100',
            'address'  => 'required|string|max:255',
            'profile_picture' => 'required|image|max:5120', 

        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Sauvegarde de l'image
        $path = $request->file('profile_picture')->store('profiles', 'public');
        logger('Received file: ' . $request->file('profile_picture'));
        logger('Stored profile path: ' . $path);


        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'country' => $request->country,
            'address' => $request->address,
            'profile_picture' => $path,
            'password' => '', // temporairement vide
        ]);

        return response()->json($user, 200);
    }

    // Étape 2 : ajout du mot de passe et bio
    public function completeSignup(Request $request)
    {
        logger('complete signup ');
        $request->validate([
            'user_id' => 'required|exists:users,id',
            'bio' => 'required|string|max:1000',
            'password' => 'required|min:6',
        ]);

        $user = User::find($request->user_id);
        $user->bio = $request->bio;
        $user->password = Hash::make($request->password);
        $user->save();

        return response()->json($user, 200);
    }

    // Étape 3 : validation finale
    public function finalize(Request $request)
    {
        $request->validate([
            'email' => 'required|email|exists:users,email',
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json([
                'message' => 'User not found.',
            ], 404);
        }

        $user->email_verified_at = Carbon::now(); 
        $user->save();

        return response()->json([
            'message' => 'User registration finalized successfully.',
            'user' => $user
        ]);
    }

    public function setRole(Request $request)
    {
        $request->validate([
            'role' => 'required|in:coach,sporty',
        ]);

        $user = $request->user();
        $user->role = $request->role;
        $user->save();

        return response()->json([
            'message' => 'Role updated successfully',
            'role' => $user->role,
        ]);
    }

    public function login(Request $request)
    {
        //dd($request->all());
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if (!Auth::attempt($request->only('email', 'password'))) {
            return response()->json([
                'message' => 'Invalid login details'
            ], 401);
        }

        $user = Auth::user();
        $token = $user->createToken('mobile_token')->plainTextToken;

        return response()->json([
            'message' => 'Login successful',
            'user' => $user,
            'token' => $token,
        ]);
    }

    public function updateCoachProfile(Request $request)
    {
        logger('update coach profile');
        $user = auth()->user();

        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email,' . $user->id,
            'address' => 'nullable|string|max:255',
            'password' => 'nullable|string|min:6', 
            'profile_picture' => 'required|image|max:5120',
        ]);
        logger($request->all());

        $user->name = $request->name;
        $user->email = $request->email;
        $user->address = $request->address;

        if ($request->filled('password')) {
            $user->password = Hash::make($request->password);
        }

        if ($request->hasFile('profile_picture')) {
            // Supprimer l’ancienne photo si elle existe
            if ($user->profile_picture && Storage::exists($user->profile_picture)) {
                Storage::delete($user->profile_picture);
            }

            // Stocker la nouvelle
            $path = $request->file('profile_picture')->store('profile_pictures', 'public');
            $user->profile_picture = '/storage/' . $path;
        }

        $user->save();

        return response()->json([
            'message' => 'Profile updated successfully',
            'user' => $user,
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Logged out successfully'
        ]);
    }
}


