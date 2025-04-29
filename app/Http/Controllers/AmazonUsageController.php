<?php
namespace App\Http\Controllers;

use App\Models\AmazonUsageHistory;
use Carbon\Carbon;
use Illuminate\Http\Request;

class AmazonUsageController extends Controller
{
    const STATUS_NONE = null;
    const STATUS_OK   = true;
    const STATUS_NG   = false;

    public function index(Request $request)
    {
        $date        = $request->input('date');
        $currentDate = $date ? Carbon::parse($date) : Carbon::now();

        $startOfMonth = $currentDate->copy()->startOfMonth();
        $endOfMonth   = $currentDate->copy()->endOfMonth();

        $usageHistory = AmazonUsageHistory::whereBetween('date', [$startOfMonth, $endOfMonth])
            ->get()
            ->keyBy(function ($item) {
                return $item->date;
            });

        return view('amazon.index', compact('currentDate', 'usageHistory'));
    }

    public function toggle(Request $request)
    {
        $date = $request->input('date');
        if (! $date) {
            return response()->json(['success' => false, 'message' => '日付が指定されていません'], 400);
        }

        try {
            $usage         = AmazonUsageHistory::firstOrNew(['date' => $date]);
            $currentStatus = $usage->exists ? $usage->is_used : self::STATUS_NONE;
            $nextStatus    = 'none';

            \Log::info('Current status:', [
                'status'  => $currentStatus,
                'exists'  => $usage->exists,
                'is_used' => $usage->is_used,
                'type'    => gettype($currentStatus),
            ]);

            // 状態を切り替え（null → true → false → null）
            if ($currentStatus === self::STATUS_NONE) {
                $usage->is_used = true;
                $nextStatus     = 'ok';
            } elseif ($currentStatus == true) { // 緩い比較を使用
                $usage->is_used = false;
                $nextStatus     = 'ng';
            } elseif ($currentStatus == false) { // 緩い比較を使用
                if ($usage->exists) {
                    $usage->delete();
                }
                $nextStatus = 'none';
                return response()->json([
                    'success' => true,
                    'status'  => $nextStatus,
                    'date'    => $date,
                ]);
            }

            $usage->save();

            \Log::info('After save:', [
                'next_status' => $nextStatus,
                'is_used'     => $usage->is_used,
                'raw_value'   => $usage->getRawOriginal('is_used'),
                'type'        => gettype($usage->is_used),
            ]);

            return response()->json([
                'success' => true,
                'status'  => $nextStatus,
                'date'    => $date,
            ]);

        } catch (\Exception $e) {
            \Log::error('Toggle error:', ['error' => $e->getMessage()]);
            return response()->json([
                'success' => false,
                'message' => 'エラーが発生しました: ' . $e->getMessage(),
            ], 500);
        }
    }
}
