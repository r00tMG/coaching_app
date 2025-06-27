<?php

namespace App\Http\Controllers\Admin\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class BankDetailController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'bank_name' => 'required|string',
            'account_number' => 'required|string',
            'first_name' => 'required|string',
            'last_name' => 'required|string',
            'city' => 'required|string',
            'postal_code' => 'required|string',
        ]);

        $user = auth()->user();

        $user->bankDetail()->updateOrCreate([], [
            'bank_name' => $request->bank_name,
            'account_number' => $request->account_number,
            'first_name' => $request->first_name,
            'last_name' => $request->last_name,
            'city' => $request->city,
            'postal_code' => $request->postal_code,
        ]);

        return response()->json(['message' => 'Bank details saved successfully.'], 200);
    }

}
