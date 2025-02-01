<?php

namespace App\Http\Controllers;

use App\Models\Spending;
use Illuminate\Http\Request;

class SpendingController extends Controller
{
    public function search(Request $request)
    {
        $keyword = $request->input('keyword');

        $spendings = Spending::where('description', 'LIKE', "%{$keyword}%")
            ->orderBy('created_at', 'desc')
            ->get();

        $totalAmount = $spendings->sum('tgtmoney');

        return view('spendings.search', compact('spendings', 'totalAmount', 'keyword'));
    }
}
