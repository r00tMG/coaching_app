<?php

namespace App\Http\Controllers\Admin\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Stripe\Stripe;
use Stripe\Customer;
use Config;

class SubscriptionController extends Controller
{
    public function subscribe(Request $request)
    {
        $user = Auth::user();
        $request->validate([
            'plan' => 'required|in:basic,pro',
            'payment_method' => 'required|string',
        ]);

        $priceId = $request->plan === 'basic'
            ? env('STRIPE_BASIC_PRICE_ID')
            : env('STRIPE_PRO_PRICE_ID');

        Stripe::setApiKey(env('STRIPE_SECRET'));

        if (!$user->hasStripeId()) {
            $user->createAsStripeCustomer();
        }

        $user->updateDefaultPaymentMethod($request->payment_method);

        $user->newSubscription('default', $priceId)->create($request->payment_method);

        return response()->json(['message' => 'Abonnement activé avec succès.']);
    }

    public function cancel()
    {
        $user = Auth::user();
        $user->subscription('default')->cancel();

        return response()->json(['message' => 'Abonnement annulé avec succès.']);
    }

    public function resume()
    {
        $user = Auth::user();
        $user->subscription('default')->resume();

        return response()->json(['message' => 'Abonnement repris avec succès.']);
    }
}
