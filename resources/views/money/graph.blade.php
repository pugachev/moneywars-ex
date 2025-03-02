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

<!-- 支出データ一覧モーダル -->
<div class="modal fade" id="dailySpendingList" tabindex="-1" role="dialog" aria-labelledby="dailySpendingListLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="dailySpendingListLabel">支出一覧</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="spendingListContent">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>金額</th>
                                <th>項目</th>
                                <th>説明</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody id="spendingListBody">
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">閉じる</button>
            </div>
        </div>
    </div>
</div>

<!-- 編集モーダル -->
<div class="modal fade" id="editSpendingModal" tabindex="-1" role="dialog" aria-labelledby="editSpendingModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editSpendingModalLabel">支出の編集</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editSpendingForm">
                    <input type="hidden" id="edit_spending_id">
                    <div class="form-group">
                        <label for="edit_tgtmoney">金額</label>
                        <input type="number" class="form-control" id="edit_tgtmoney" required>
                    </div>
                    <div class="form-group">
                        <label for="edit_tgtitem">項目</label>
                        <select class="form-control" id="edit_tgtitem" required>
                            <option value="1">食費</option>
                            <option value="2">日用品</option>
                            <option value="3">衣服</option>
                            <option value="4">交通費</option>
                            <option value="5">その他</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="edit_description">説明</label>
                        <input type="text" class="form-control" id="edit_description">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">キャンセル</button>
                <button type="button" class="btn btn-primary" id="saveEdit">保存</button>
            </div>
        </div>
    </div>
</div>

@push('scripts')
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
let myChart = null;
const ITEM_NAMES = {
    1: '食費',
    2: '日用品',
    3: '衣服',
    4: '交通費',
    5: 'その他'
};

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
            },
            onClick: async (event, elements) => {
                if (elements.length > 0) {
                    const index = elements[0].index;
                    const date = Object.keys(data)[index];
                    const activeTab = document.querySelector('#monthTabs .nav-link.active');
                    const month = activeTab.dataset.month;
                    const fullDate = `${month}-${date.padStart(2, '0')}`;

                    try {
                        const appUrl = '{{ config('app.url') }}';
                        const isProduction = appUrl.includes('moneywars-ex.ikefukuro40.tech');
                        const basePath = isProduction ? '/public' : '';

                        const response = await fetch(`${basePath}/money/daily/${fullDate}`);
                        if (response.ok) {
                            const spendingData = await response.json();
                            updateSpendingList(spendingData, fullDate);
                        } else {
                            throw new Error('データの取得に失敗しました');
                        }
                    } catch (error) {
                        console.error('Error:', error);
                        alert('データの取得に失敗しました');
                    }
                }
            }
        }
    });
}

function updateSpendingList(data, date) {
    $('#spendingListBody').empty();
    $('#dailySpendingListLabel').text(date + ' の支出一覧');

    data.forEach(function(spending) {
        const row = `
            <tr>
                <td>${Number(spending.tgtmoney).toLocaleString()}円</td>
                <td>${ITEM_NAMES[spending.tgtitem] || '不明'}</td>
                <td>${spending.description || '説明なし'}</td>
                <td>
                    <button class="btn btn-sm btn-primary edit-spending mr-2"
                            data-id="${spending.id}"
                            data-money="${spending.tgtmoney}"
                            data-item="${spending.tgtitem}"
                            data-description="${spending.description || ''}">
                        編集
                    </button>
                    <button class="btn btn-sm btn-danger delete-spending" data-id="${spending.id}">
                        削除
                    </button>
                </td>
            </tr>
        `;
        $('#spendingListBody').append(row);
    });

    $('#dailySpendingList').modal('show');
}

// 初期表示
document.addEventListener('DOMContentLoaded', function() {
    const currentMonth = '{{ $currentMonth }}';
    updateGraph(currentMonth);

    // モーダルの閉じるボタンのイベントハンドラを追加
    $('.modal .close, .modal .btn-secondary').on('click', function() {
        $(this).closest('.modal').modal('hide');
    });

    // 削除ボタンのクリックイベント
    $(document).on('click', '.delete-spending', function() {
        if (confirm('本当に削除しますか？')) {
            const id = $(this).data('id');
            const appUrl = '{{ config('app.url') }}';
            const isProduction = appUrl.includes('moneywars-ex.ikefukuro40.tech');
            const basePath = isProduction ? '/public' : '';

            $.ajax({
                url: `${basePath}/money/${id}`,
                method: 'DELETE',
                data: {
                    _token: '{{ csrf_token() }}'
                },
                success: function(response) {
                    $('#dailySpendingList').modal('hide');
                    const activeTab = document.querySelector('#monthTabs .nav-link.active');
                    updateGraph(activeTab.dataset.month);
                },
                error: function() {
                    alert('削除に失敗しました');
                }
            });
        }
    });

    // 編集ボタンのクリックイベント
    $(document).on('click', '.edit-spending', function() {
        const id = $(this).data('id');
        const money = $(this).data('money');
        const item = $(this).data('item');
        const description = $(this).data('description');

        $('#edit_spending_id').val(id);
        $('#edit_tgtmoney').val(money);
        $('#edit_tgtitem').val(item);
        $('#edit_description').val(description);

        $('#editSpendingModal').modal('show');
        $('#dailySpendingList').modal('hide');
    });

    // 保存ボタンのクリックイベント
    $('#saveEdit').on('click', function() {
        const id = $('#edit_spending_id').val();
        const appUrl = '{{ config('app.url') }}';
        const isProduction = appUrl.includes('moneywars-ex.ikefukuro40.tech');
        const basePath = isProduction ? '/public' : '';

        const data = {
            tgtmoney: $('#edit_tgtmoney').val(),
            tgtitem: $('#edit_tgtitem').val(),
            description: $('#edit_description').val(),
            _token: '{{ csrf_token() }}'
        };

        $.ajax({
            url: `${basePath}/money/${id}`,
            method: 'PUT',
            data: data,
            success: function(response) {
                $('#editSpendingModal').modal('hide');
                const activeTab = document.querySelector('#monthTabs .nav-link.active');
                updateGraph(activeTab.dataset.month);
            },
            error: function() {
                alert('更新に失敗しました');
            }
        });
    });
});
</script>
@endpush
@endsection
