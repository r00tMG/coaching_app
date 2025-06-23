<?php

namespace App\Http\Controllers\Admin\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\NotificationCustom;

class NotificationCustomController extends Controller
{
    public function index()
    {
        $userId = auth()->id();

        $notifications = NotificationCustom::where('user_id', $userId)
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json($notifications);
    }

    public function markAsRead($id)
    {
        $notif = NotificationCustom::where('id', $id)->where('user_id', Auth::id())->firstOrFail();
        $notif->update(['is_read' => true]);

        return response()->json(['success' => true]);
    }

    public function destroy($id)
    {
        $notif = NotificationCustom::where('id', $id)->where('user_id', Auth::id())->firstOrFail();
        $notif->delete();
        return response()->json(['success' => true]);
    }
}
