<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class MoneyController extends Controller
{
    public function index()
    {
        // resources/views/index.blade.phpを表示する
        return view('money.index');
    }

    public function getJsonData(Request $request)
    {
        $yearMonth = $request->input('yearMonth', date('Y-m'));
        \Log::info('getJsonData: ' . $yearMonth); // 受け取った年月をログ出力

        $year = substr($yearMonth, 0, 4);
        $month = substr($yearMonth, 5, 2);

        $spendings = DB::table('spendings')
            ->select(
                DB::raw('DATE_FORMAT(tgtdate, "%d") as day'),
                DB::raw('SUM(tgtmoney) as total')
            )
            ->whereYear('tgtdate', $year)
            ->whereMonth('tgtdate', $month)
            ->groupBy('day')
            ->get();

        \Log::info('spendings: ' . $spendings); // 取得したデータをログ出力

        return response()->json($spendings);
    }
}
