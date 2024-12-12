<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;

class MoneyController extends Controller
{
    public function index()
    {
        // resources/views/index.blade.phpを表示する
        return view('money.index');
    }

    public function getJsonData(Request $request){

        // $tgtdate = $tgtdate ?? Carbon::now()->format('Y-m-d');
        $tgtdate = $request->input('tgtdate', Carbon::now()->format('Y-m-d'));
        // Log::info('getJsonData(1) '.$year.'-'.$month);
        $year = Carbon::parse($tgtdate)->year;
        $month = Carbon::parse($tgtdate)->month;
        $data = [
            'year' => $year,
            'month' => $month,
            'event' => [
                ['day' => '1', 'title' => 'イベント1', 'type' => 'blue'],
                ['day' => '2', 'title' => 'イベント2', 'type' => 'red'],
                ['day' => '3', 'title' => 'イベント3', 'type' => 'green'],
                ['day' => '3', 'title' => 'イベント4'],
                ['day' => '5', 'title' => 'イベント5', 'type' => 'blue'],
                ['day' => '5', 'title' => 'イベント6', 'type' => 'red'],
                ['day' => '7', 'title' => 'イベント7'],
                ['day' => '8', 'title' => 'イベント8', 'type' => 'blue'],
                ['day' => '8', 'title' => 'イベント9'],
                ['day' => '10', 'title' => 'イベント10'],
                ['day' => '10', 'title' => 'イベント11'],
                ['day' => '12', 'title' => 'イベント12', 'type' => 'green'],
                ['day' => '14', 'title' => 'イベント13'],
                ['day' => '14', 'title' => 'イベント14', 'type' => 'red'],
                ['day' => '15', 'title' => 'イベント15', 'type' => 'blue'],
                ['day' => '17', 'title' => 'イベント16'],
                ['day' => '19', 'title' => 'イベント17', 'type' => 'blue'],
                ['day' => '21', 'title' => 'イベント18'],
                ['day' => '24', 'title' => 'イベント19', 'type' => 'red'],
                ['day' => '24', 'title' => 'イベント20'],
                ['day' => '26', 'title' => 'イベント21', 'type' => 'green'],
                ['day' => '28', 'title' => 'イベント22', 'type' => 'blue'],
                ['day' => '28', 'title' => 'イベント23'],
                ['day' => '28', 'title' => 'イベント24', 'type' => 'green'],
                ['day' => '29', 'title' => 'イベント25', 'type' => 'red'],
                ['day' => '29', 'title' => 'イベント26'],
            ],
            'holiday' => ['3', '4', '5'],
        ];
        Log::info('getJsonData(2) '.$year.'-'.$month);
        // JSONデータを返却
        return response()->json($data, 200, [], JSON_UNESCAPED_UNICODE);
    }   
}
