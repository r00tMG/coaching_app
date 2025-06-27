<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Crypt;


class BankDetail extends Model
{
    use HasFactory;

    protected $guarded = [];

    public function setAccountNumberAttribute($value)
    {
        $this->attributes['account_number'] = Crypt::encryptString($value);
    }

    public function getAccountNumberAttribute($value)
    {
        return Crypt::decryptString($value);
    }
}
