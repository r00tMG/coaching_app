<?php

namespace App\Http\Controllers\Admin\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redirect;
use Stripe\StripeClient;


class StripeController extends Controller
{
    public function refresh($id)
    {
        $stripe = new StripeClient(env("PRIVATE_KEY"));

        $accountLink = $stripe->accountLinks->create([
            'account' => $id,
            'refresh_url' => url('/stripe/refresh/' . $id),
            'return_url' => url('/stripe/return'),
            'type' => 'account_onboarding',
        ]);

        return Redirect::to($accountLink->url);
    }

    public function return()
    {
        return view('stripe.return'); // ou une redirection vers un dashboard
    }
}
