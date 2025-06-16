<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Carbon;
use App\Models\Event;


class EventSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Event::create([
            'title' => 'Fitness',
            'description' => 'Session de sport intense',
            'start_time' => Carbon::parse('2025-05-02 08:00:00'),
            'end_time' => Carbon::parse('2025-05-02 10:00:00'),
            'image_url' => 'https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg',
            'coach_id' => 1, // mets un ID utilisateur valide
        ]);
    }
}
