<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SpendingsTableSeeder extends Seeder
{
    public function run()
    {
        // 既存のデータを全て削除
        DB::table('spendings')->truncate();

        // 2024年12月のデータ（20件）
        for ($day = 1; $day <= 20; $day++) {
            DB::table('spendings')->insert([
                'tgtdate' => "2024-12-{$day}",
                'tgtmoney' => rand(1000, 10000),
                'tgtitem' => rand(1, 5),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }

        // 2024年11月のデータ（18件）
        for ($day = 1; $day <= 18; $day++) {
            DB::table('spendings')->insert([
                'tgtdate' => "2024-11-{$day}",
                'tgtmoney' => rand(500, 5000),
                'tgtitem' => rand(1, 3),
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
