<?php

namespace App\Http\Controllers\Admin\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Message;
use Illuminate\Support\Facades\Auth;

class MessageController extends Controller
{
    public function getUserConversations(Request $request)
    {
        $userId = Auth::id();

        $messages = Message::where('sender_id', $userId)
            ->orWhere('receiver_id', $userId)
            ->with(['sender', 'receiver'])
            ->orderBy('created_at', 'desc')
            ->get();

        $grouped = $messages->groupBy(function ($msg) use ($userId) {
            return $msg->sender_id == $userId ? $msg->receiver_id : $msg->sender_id;
        });

        $conversations = $grouped->map(function ($msgs, $userId) {
            $last = $msgs->last();
            $user = $last->sender_id == Auth::id() ? $last->receiver : $last->sender;

            return [
                'receiver_id' => $user->id,
                'username' => $user->name,
                'user_image' => $user->profile_photo_path
                    ? asset('storage/' . $user->profile_photo_path)
                    : asset('default/avatar.png'),
                'last_message' => $last->content,
                'last_time' => $last->created_at->format('h:i A'),
            ];
        })->values();

        return response()->json($conversations);
    }
    public function sendMessage(Request $request)
    {
        $request->validate([
            'receiver_id' => 'required|exists:users,id',
            'content' => 'required|string|max:1000',
        ]);

        $message = Message::create([
            'sender_id' => auth()->id(), // Assure-toi que l'utilisateur est connecté
            'receiver_id' => $request->receiver_id,
            'content' => $request->content,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Message envoyé avec succès',
            'data' => $message
        ]);
    }
}
