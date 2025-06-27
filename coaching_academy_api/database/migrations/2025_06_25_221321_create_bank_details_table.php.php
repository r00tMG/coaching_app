<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('bank_details', function (Blueprint $table) {
            $table->id();

            // Clé étrangère vers l'utilisateur
            $table->foreignId('user_id')->constrained()->onDelete('cascade');

            // Champs bancaires
            $table->string('bank_name');
            $table->string('account_number');
            $table->string('first_name');
            $table->string('last_name');
            $table->string('city');
            $table->string('postal_code');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('bank_details');
    }
};
