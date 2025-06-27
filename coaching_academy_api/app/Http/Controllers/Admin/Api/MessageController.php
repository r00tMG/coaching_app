<?php

namespace App\Http\Controllers\Admin\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Message;
use Illuminate\Support\Facades\Auth;
use App\Models\NotificationCustom;
use Carbon\Carbon;


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
                'last_time' => Carbon::parse($last->created_at)
                    ->locale('fr_FR') 
                    ->format('H:i')
                    
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
            'sender_id' => auth()->id(), 
            'receiver_id' => $request->receiver_id,
            'content' => $request->content,
        ]);
        //logger("sender :".$message.sender_id);

        NotificationCustom::create([
            'user_id' => $request->receiver_id,
            'title' => 'Nouveau message',
            'description' => 'Vous avez reçu un message de ' . auth()->user()->name,
            'sender_id' => auth()->user()->id,
            'sender_name' => auth()->user()->name,
            'sender_image' => auth()->user()->profile_picture
                ? asset('storage/' . auth()->user()->profile_picture)
                : asset('default/avatar.png'),
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Message envoyé avec succès',
            'data' => $message
        ]);
    }

    public function getMessagesWith($receiverId)
    {
        $userId = auth()->id();

        $messages = Message::where(function ($query) use ($userId, $receiverId) {
            $query->where('sender_id', $userId)->where('receiver_id', $receiverId);
        })->orWhere(function ($query) use ($userId, $receiverId) {
            $query->where('sender_id', $receiverId)->where('receiver_id', $userId);
        })
        ->orderBy('created_at')
        ->get()
        ->map(function ($msg) {
            return [
                'id' => $msg->id,
                'sender_id' => $msg->sender_id,
                'receiver_id' => $msg->receiver_id,
                'content' => $msg->content,
                'created_at' => Carbon::parse($msg->created_at)
                    ->locale('fr_FR') 
                    ->isoFormat('dddd, DD MMMM YYYY [à] HH:mm'),
            ];
        });

        return response()->json($messages);
    }


}
