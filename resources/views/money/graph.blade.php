@extends('layouts.app')

@push('styles')
<style>
body {
    margin: 0;
    padding: 0;
}
</style>
@endpush

@section('content')
<nav class="navbar navbar-expand-lg navbar-dark bg-warning mb-0 ml-1">
    <a class="navbar-brand" href="{{route('money.index')}}">moneywars</a>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <!-- 左側のナビゲーション -->
        <ul class="navbar-nav d-flex align-items-center">
            <li class="nav-item active d-flex align-items-center">
                <a class="nav-link" href="#" data-toggle="modal" data-target="#addSpendingModal" style="color: white;font-weight: bold;">
                    新規
                </a>
                <span class="ml-3 mr-5" style="color: white;font-weight: bold;">月間目標 : 100000円</span>
            </li>
        </ul>
    </div>
</nav>

<div class="container mt-5">
    <!-- タブナビゲーション -->
    <ul class="nav nav-tabs mb-4" id="monthTabs">
        @foreach($months as $month)
        <li class="nav-item">
            <button class="nav-link {{ $month === $currentMonth ? 'active' : '' }}"
                    data-month="{{ $month }}"
                    onclick="updateGraph('{{ $month }}')">
                {{ \Carbon\Carbon::parse($month)->format('Y年n月') }}
            </button>
        </li>
        @endforeach
    </ul>

    <canvas id="spendingGraph"></canvas>
</div>

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
let myChart = null;

async function updateGraph(month) {
    try {
        // APP_URLを使用して環境を判定
        const appUrl = '{{ config('app.url') }}';
        const isProduction = appUrl.includes('moneywars-ex.ikefukuro40.tech');
        const basePath = isProduction ? '/public' : '';

        const response = await fetch(`${basePath}/money/graph/data?month=${month}`);

        if (response.ok) {
            const data = await response.json();

            // タブの状態を更新
            document.querySelectorAll('#monthTabs .nav-link').forEach(tab => {
                tab.classList.remove('active');
                if (tab.dataset.month === month) {
                    tab.classList.add('active');
                }
            });

            createChart(data);
        } else {
            throw new Error(`データの取得に失敗しました (${response.status})`);
        }
    } catch (error) {
        console.error('Error:', error);
        alert('データの取得に失敗しました');
    }
}

function createChart(data) {
    const ctx = document.getElementById('spendingGraph').getContext('2d');

    if (myChart) {
        myChart.destroy();
    }

    myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: Object.keys(data),
            datasets: [{
                label: '日別支出',
                data: Object.values(data),
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: '金額（円）'
                    }
                },
                x: {
                    title: {
                        display: true,
                        text: '日付'
                    }
                }
            }
        }
    });
}

// 初期表示
document.addEventListener('DOMContentLoaded', function() {
    const currentMonth = '{{ $currentMonth }}';
    updateGraph(currentMonth);
});
</script>
@endpush
@endsection
