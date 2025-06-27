<?php

namespace App\Http\Controllers\Admin\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Stripe\Stripe;
use Stripe\Checkout\Session;

class StripePaymentController extends Controller
{
    public function createCheckoutSession(Request $request)
    {
        $validated = $request->validate([
            'price' => 'required|numeric|min:1',
            'service_name' => 'required|string',
        ]);

        Stripe::setApiKey(env('STRIPE_SECRET'));

        $session = Session::create([
            'payment_method_types' => ['card'],
            'line_items' => [[
                'price_data' => [
                    'currency' => 'usd',
                    'product_data' => [
                        'name' => $validated['service_name'],
                    ],
                    'unit_amount' => $validated['price'] * 100, 
                ],
                'quantity' => 1,
            ]],
            'mode' => 'payment',
            'success_url' => url('/payment/success'),
            'cancel_url' => url('/payment/cancel'),
        ]);

        return response()->json(['url' => $session->url]);
    }
}
