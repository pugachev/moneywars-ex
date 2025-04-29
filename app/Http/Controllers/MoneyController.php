<?php
namespace App\Http\Controllers;

use App\Models\Spending;
use DateTime;
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
        $tgtdate = $request->input('tgtdate', date('Y-m-d'));
        $date    = new DateTime($tgtdate);

        $year  = $date->format('Y');
        $month = $date->format('n');

        // 通常の支出を日付ごとに集計
        $spendings = DB::table('spendings')
            ->select(
                'tgtdate',
                DB::raw('DAY(tgtdate) as day'),
                'tgtmoney',
                'tgtitem',
                'description'
            )
            ->whereYear('tgtdate', $year)
            ->whereMonth('tgtdate', $month)
            ->get();

        // 項目別の合計を計算
        $itemTotals = [
            1 => 0, // 食費
            2 => 0, // 日用品
            3 => 0, // 衣服
            4 => 0, // 交通費
            5 => 0, // その他
        ];

        // Amazon支出の合計
        $amazonTotal = 0;

        // 日付ごとの合計を計算
        $dailyTotals = [];
        foreach ($spendings as $spending) {
            $day    = (int) date('d', strtotime($spending->tgtdate));
            $amount = $spending->tgtmoney;

            // Amazon支出の判定と集計
            if ($spending->description && str_contains(strtolower($spending->description), 'amazon')) {
                $amazonTotal += $amount;
            } else {
                // 通常の項目別合計に加算
                $itemTotals[$spending->tgtitem] += $amount;
            }

            // 日付ごとの合計を集計
            if (! isset($dailyTotals[$day])) {
                $dailyTotals[$day] = [
                    'total' => 0,
                    'items' => [],
                ];
            }
            $dailyTotals[$day]['total'] += $amount;
            $dailyTotals[$day]['items'][] = [
                'amount'      => $amount,
                'item'        => $spending->tgtitem,
                'description' => $spending->description,
            ];
        }

        // イベントデータを作成
        $events = [];
        foreach ($dailyTotals as $day => $data) {
            $events[] = [
                'title'  => number_format($data['total']) . '円',
                'day'    => (int) $day,
                'amount' => $data['total'],
                'items'  => $data['items'],
                'type'   => 'expense',
            ];
        }

        // 月間合計を計算
        $monthlyTotal = array_sum($itemTotals) + $amazonTotal;

        return response()->json([
            'event'        => $events,
            'year'         => (int) $year,
            'month'        => (int) $month,
            'holiday'      => [],
            'monthlyTotal' => array_sum($itemTotals) + $amazonTotal,
            'itemTotals'   => $itemTotals,
            'amazonTotal'  => $amazonTotal,
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'date'    => 'required|date',
            'amount'  => 'required|numeric',
            'tgtitem' => 'required|numeric|between:1,5',
        ]);

        Spending::create([
            'tgtdate'  => $validated['date'],
            'tgtmoney' => $validated['amount'],
            'tgtitem'  => $validated['tgtitem'],
        ]);

        return redirect()->route('money.index')
            ->with('message', '支出を登録しました。');
    }

    public function daily($date)
    {
        \Log::info('Requested date: ' . $date);
        $spendings = Spending::whereDate('tgtdate', $date)->get();
        \Log::info('Found spendings:', $spendings->toArray());
        return response()->json($spendings);
    }

    public function destroy($id)
    {
        $spending = Spending::findOrFail($id);
        $spending->delete();
        return response()->json(['success' => true]);
    }

    public function update(Request $request, $id)
    {
        $validated = $request->validate([
            'tgtmoney'    => 'required|numeric',
            'tgtitem'     => 'required|numeric|between:1,5',
            'description' => 'nullable|string|max:255',
        ]);

        $spending = Spending::findOrFail($id);
        $spending->update($validated);

        return response()->json(['message' => '更新しました']);
    }
}
