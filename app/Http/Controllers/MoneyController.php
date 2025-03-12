<?php
namespace App\Http\Controllers;

use App\Models\Spending;
use Carbon\Carbon;
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

        // 月間合計を取得
        $monthlyTotal = DB::table('spendings')
            ->whereYear('tgtdate', $year)
            ->whereMonth('tgtdate', $month)
            ->sum('tgtmoney');

        // Amazonの支出合計を取得
        $amazonTotal = DB::table('spendings')
            ->whereYear('tgtdate', $year)
            ->whereMonth('tgtdate', $month)
            ->where('description', 'like', '%Amazon%')
            ->sum('tgtmoney');

        // 項目ごとの合計を計算
        $itemTotals = DB::table('spendings')
            ->select('tgtitem', DB::raw('SUM(tgtmoney) as total'))
            ->whereYear('tgtdate', $year)
            ->whereMonth('tgtdate', $month)
            ->groupBy('tgtitem')
            ->get()
            ->pluck('total', 'tgtitem')
            ->toArray();

        \Log::info('Item totals calculation:', [
            'year' => $year,
            'month' => $month,
            'sql' => DB::table('spendings')
                ->select('tgtitem', DB::raw('SUM(tgtmoney) as total'))
                ->whereYear('tgtdate', $year)
                ->whereMonth('tgtdate', $month)
                ->groupBy('tgtitem')
                ->toSql(),
            'bindings' => DB::table('spendings')
                ->select('tgtitem', DB::raw('SUM(tgtmoney) as total'))
                ->whereYear('tgtdate', $year)
                ->whereMonth('tgtdate', $month)
                ->groupBy('tgtitem')
                ->getBindings(),
            'itemTotals' => $itemTotals,
            'raw_data' => DB::table('spendings')
                ->select('tgtitem', 'tgtmoney', 'tgtdate')
                ->whereYear('tgtdate', $year)
                ->whereMonth('tgtdate', $month)
                ->get()
        ]);

        \Log::info('Monthly total calculation:', [
            'year'     => $year,
            'month'    => $month,
            'total'    => $monthlyTotal,
            'sql'      => DB::table('spendings')
                ->whereYear('tgtdate', $year)
                ->whereMonth('tgtdate', $month)
                ->toSql(),
            'monthlyTotal' => $monthlyTotal,
            'itemTotals' => $itemTotals,
        ]);

        $spendings = DB::table('spendings')
            ->select(
                DB::raw('DAY(tgtdate) as day'), // 日付の日部分のみ
                DB::raw('SUM(tgtmoney) as amount')
            )
            ->whereYear('tgtdate', $year)
            ->whereMonth('tgtdate', $month)
            ->groupBy('day')
            ->get()
            ->map(function ($item) {
                return [
                    'day'   => (int) $item->day,
                    'title' => number_format($item->amount) . '円',
                    'type'  => 'expense',
                ];
            })
            ->values()
            ->toArray();

        return response()->json([
            'event'        => $spendings,
            'year'         => (int) $year,
            'month'        => (int) $month,
            'holiday'      => [],
            'monthlyTotal' => $monthlyTotal,
            'itemTotals'   => $itemTotals,
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

    public function search(Request $request)
    {
        $keyword = $request->input('keyword');

        $spendings = \App\Models\Spending::where('description', 'LIKE', "%{$keyword}%")
            ->orderBy('tgtdate', 'desc') // created_atではなくtgtdateでソート
            ->paginate(10);

        $totalAmount = \App\Models\Spending::where('description', 'LIKE', "%{$keyword}%")
            ->sum('tgtmoney');

        return view('money.search', compact('spendings', 'totalAmount', 'keyword'));
    }

    public function graph()
    {
        // 過去6ヶ月分の年月を生成
        $months = collect();
        for ($i = 0; $i < 6; $i++) {
            $months->push(Carbon::now()->subMonths($i)->format('Y-m'));
        }

        $currentMonth = request('month', Carbon::now()->format('Y-m'));
        $data         = $this->getMonthlyData($currentMonth);

        return view('money.graph', [
            'spendings'    => $data,
            'currentMonth' => $currentMonth,
            'months'       => $months,
        ]);
    }

    public function graphData(Request $request)
    {
        $month = $request->get('month', Carbon::now()->format('Y-m'));
        $data  = $this->getMonthlyData($month);
        return response()->json($data);
    }

    private function getMonthlyData($month)
    {
        $startOfMonth = Carbon::parse($month)->startOfMonth();
        $daysInMonth  = $startOfMonth->daysInMonth;

        // 配列を作成（0埋めなし）
        $result = [];
        for ($day = $daysInMonth; $day >= 1; $day--) {
            $result[$day] = 0;
        }

        $spendings = Spending::whereYear('tgtdate', $startOfMonth->year)
            ->whereMonth('tgtdate', $startOfMonth->month)
            ->orderBy('tgtdate', 'desc')
            ->get()
            ->groupBy(function ($spending) {
                // 日付を数値として取得
                return (int) Carbon::parse($spending->tgtdate)->format('d');
            })
            ->map(function ($group) {
                return $group->sum('tgtmoney');
            });

        // 支出データをマージ
        foreach ($spendings as $day => $amount) {
            $result[(int) $day] = $amount;
        }

        // キーで降順ソート
        krsort($result);

        return $result;
    }
}
