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
        Schema::table('notification_customs', function (Blueprint $table) {
            $table->unsignedBigInteger('sender_id')->nullable()->after('user_id');
            $table->string('sender_name')->nullable()->after('sender_id');
            $table->string('sender_image')->nullable()->after('sender_name');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('notification_customs', function (Blueprint $table) {
            $table->dropColumn(['sender_id', 'sender_name', 'sender_image']);
        });
    }
};
