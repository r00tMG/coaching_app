<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Admin\Api\UserController;
use App\Http\Controllers\Admin\Api\ServiceController;
use App\Http\Controllers\Admin\Api\CoachLocationController;
use App\Http\Controllers\Admin\Api\EventController;
use App\Http\Controllers\Admin\Api\Coach\WorkingHourController;
use App\Http\Controllers\Admin\Api\PostController;
use App\Http\Controllers\Admin\Api\CoachBookingController;
use App\Http\Controllers\Admin\Api\ContactMessageController;
use App\Http\Controllers\Admin\Api\MessageController;
use App\Http\Controllers\Admin\Api\NotificationCustomController;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::post('/login', [UserController::class, 'login']);
Route::post('/signup', [UserController::class, 'initialSignup']);
Route::post('/complete-signup', [UserController::class, 'completeSignup']);
Route::post('/validate-registration', [UserController::class, 'finalize']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/set-role', [UserController::class, 'setRole']);
    Route::post('/services', [ServiceController::class, 'store']);
    Route::post('/logout', [UserController::class, 'logout']);
    Route::post('/coach/location', [CoachLocationController::class, 'store']);
    Route::post('/coach/workspace/upload', [CoachLocationController::class, 'uploadWorkspace']);
    Route::post('/coach/services', [ServiceController::class, 'storeCoachServiceDetails']);
    Route::prefix('coach')->group(function () {
        Route::get('/services', [ServiceController::class, 'index']);
        Route::get('/services/workingHours', [ServiceController::class, 'indexServiceWithWorkingHours']);
        Route::get('/services/{id}', [ServiceController::class, 'show']);
        Route::put('/services/{id}', [ServiceController::class, 'update']);
        Route::post('/update', [UserController::class, 'updateCoachProfile']);


    });
    Route::post('/coach/working-hours', [WorkingHourController::class, 'store']);
    Route::get('/coach/working-hours', [WorkingHourController::class, 'index']);

    Route::post('/contact_us', [ContactMessageController::class, 'store']);

    Route::get('/events', [EventController::class, 'index']);

    Route::post('/posts', [PostController::class, 'store']);
    Route::get('/posts', [PostController::class, 'index']);
    Route::get('/my_posts', [PostController::class, 'indexByUser']);


    Route::get('/coach/bookings', [CoachBookingController::class, 'index']);
    Route::get('/coach/bookings/{id}', [CoachBookingController::class, 'show']);

    Route::get('/conversations', [MessageController::class, 'getUserConversations']);
    Route::post('/messages/send', [MessageController::class, 'sendMessage']);
    Route::get('/messages/{receiverId}', [MessageController::class, 'getMessagesWith']);

    Route::get('/notifications', [NotificationCustomController::class, 'index']);
    Route::post('/notifications/read/{id}', [NotificationCustomController::class, 'markAsRead']);
    Route::delete('/notifications/{id}', [NotificationCustomController::class, 'destroy']);



});
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return response()->json([
        'id' => $request->user()->id,
        'name' => $request->user()->name,
        'email' => $request->user()->email,
        'role' => $request->user()->role, 
        'profile_picture' => $request->user()->profile_picture ? asset("storage/".$request->user()->profile_picture)  : null,
        'bio' => $request->user()->bio,
        'address' => $request->user()->address
    ]);
});