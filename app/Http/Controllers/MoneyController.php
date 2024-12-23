<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use DateTime;
use App\Models\Spending;

class MoneyController extends Controller
{
    public function index()
    {
        // resources/views/index.blade.phpを表示する
        return view('money.index');
    }

    public function getJsonData(Request $request)
    {
        $tgtdate = $request->input('tgtdate', date('Y-m-d'));
        $date = new DateTime($tgtdate);

        $year = $date->format('Y');
        $month = $date->format('n'); // 先頭の0を除いた月

        $spendings = DB::table('spendings')
            ->select(
                DB::raw('DAY(tgtdate) as day'),  // 日付の日部分のみ
                DB::raw('SUM(tgtmoney) as amount')
            )
            ->whereYear('tgtdate', $year)
            ->whereMonth('tgtdate', $month)
            ->groupBy('day')
            ->get()
            ->map(function ($item) {
                return [
                    'day' => (int)$item->day,
                    'title' => number_format($item->amount) . '円',
                    'type' => 'expense'
                ];
            })
            ->values()
            ->toArray();

        return response()->json([
            'event' => $spendings,    // 注意: "events" ではなく "event"
            'year' => (int)$year,
            'month' => (int)$month,
            'holiday' => []           // 必要に応じて休日データを設定
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'date' => 'required|date',
            'amount' => 'required|numeric',
            'description' => 'nullable|string|max:255',
        ]);

        Spending::create([
            'tgtdate' => $validated['date'],
            'tgtmoney' => $validated['amount'],
            'tgtitem' => 1  // 仮の値として1を設定
        ]);

        return redirect()->route('money.index')
            ->with('message', '支出を登録しました。');
    }
}
