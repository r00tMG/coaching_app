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
        Schema::create('bookings', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('sporty_id'); // L'utilisateur qui réserve
            $table->unsignedBigInteger('coach_id'); // Coach concerné
            $table->unsignedBigInteger('coach_service_id');
            $table->date('date');
            $table->string('time');
            $table->string('gender');
            $table->string('training_place');
            $table->string('status')->default('pending');
            $table->timestamps();

            $table->foreign('sporty_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('coach_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('coach_service_id')->references('id')->on('coach_services')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('bookings');
    }
};
