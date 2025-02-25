<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SpendingsTableSeeder extends Seeder
{
    public function run()
    {
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');
        DB::table('spendings')->truncate();

        $sql = file_get_contents(database_path('seeders/ikefuku40_moneywars.sql'));

        // VALUES以降の部分を抽出
        preg_match('/INSERT INTO `spendings`.*VALUES\s*(.*?);/s', $sql, $matches);

        if (isset($matches[1])) {
            // 各行のデータを配列に分割
            $rows = explode("),\n(", trim($matches[1], "()"));

            $spendings = [];
            foreach ($rows as $row) {
                $values = str_getcsv($row, ',', "'");
                $spendings[] = [
                    'id' => trim($values[0]),
                    'tgtdate' => trim($values[1], "'"),
                    'tgtmoney' => trim($values[2]),
                    'tgtitem' => trim($values[3]),
                    'description' => $values[4] === 'NULL' ? null : trim($values[4], "'"),
                    'created_at' => trim($values[5], "'"),
                    'updated_at' => trim($values[6], "'")
                ];
            }

            // チャンクに分割してインサート
            foreach (array_chunk($spendings, 50) as $chunk) {
                DB::table('spendings')->insert($chunk);
            }
        }

        DB::statement("ALTER TABLE spendings AUTO_INCREMENT = 115;");
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');
    }
}
