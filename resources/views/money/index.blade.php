<?php

?>
<!doctype html>
<html lang="ja">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <meta name="base-url" content="{{ url('/') }}">
    <link rel="shortcut icon" href="{{ asset('/favicon.png') }}">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
    <title>MoneyWars</title>
    <style>
        /* Chrome, Safari, Edge, Opera */
        input[type=number]::-webkit-inner-spin-button,
        input[type=number]::-webkit-outer-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        /* Firefox */
        input[type=number] {
            -moz-appearance: textfield;
        }
    </style>
  </head>
  <body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-danger sticky-top mb-0">
        <a class="navbar-brand" href="{{route('money.index')}}">MoneyWars</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <!-- 左側のナビゲーション -->
            <ul class="navbar-nav d-flex align-items-center">
                <li class="nav-item active d-flex align-items-center">
                    <span>
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#addSpendingModal">
                            新規
                        </a>
                    </span>
                    <!-- 月間目標値を新規作成の隣に配置 -->
                    <span class="ml-3 navbar-text" style="color: #ffffff;font-weight: bold;">月間目標 : 100000円</span>
                    <!-- 月間実測値を月間目標値の隣に配置 -->
                    <span class="ml-3 navbar-text" style="color: #000000;font-weight: bold;"><a id="prevMonth" class="btn btn-light btn-sm" style="color: black;">前月</a></sapn>
                    <span class="ml-3 navbar-text" style="color: #000000;font-weight: bold;"><a id="nextMonthLink" class="btn btn-light btn-sm" style="color: black;">翌月</a></sapn>
                </li>
            </ul>
        </div>
    </nav>
    @if(session('message'))
    <div id="alert" class="alert alert-success">{{session('message')}}</div>
    @endif

    <div id="wrap" class="mt-5 mb-5">
        <div id="mini-calendar"></div>
    </div>
    <!-- ここに本文を記述します -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="{{ asset('js/jquery.minicalendar.js') }}"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
    <link rel="stylesheet" href="css/responsive.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
    <style>
      .form-container {
        display: flex;
        flex-direction: column; /* 縦方向に並べる */
        gap: 5px; /* フォーム間の余白を設定 */
      }
    </style>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ja.min.js"></script>
    <script type="text/javascript">

      $(function(){
        // アラートメッセージを3秒後に消す
        if ($('#alert').length > 0) {
            setTimeout(function() {
                $('#alert').fadeOut('slow');
            }, 3000);
        }

        // datepickerの設定を修正
        $('.datepicker').datepicker({
            format: 'yyyy-mm-dd',
            language: 'ja',
            autoclose: true,
            todayHighlight: true,
            clearBtn: true,  // クリアボタンを表示
            autocomplete: 'off'  // オートコンプリートを無効化
        });

        // モーダルが閉じられた時のイベント
        $('#addSpendingModal').on('hidden.bs.modal', function () {
            // フォームをリセット
            $('#addSpendingForm')[0].reset();
            $('#selected_date').val('');
        });

        // 金額入力のバリデーション
        $('#amount').on('input', function() {
            // 数字以外の文字を削除
            this.value = this.value.replace(/[^0-9]/g, '');
        });

        // フォーム送信時のバリデーション
        $('#addSpendingForm').on('submit', function(e) {
            e.preventDefault();

            const amount = $('#amount').val();
            if (!amount || isNaN(amount)) {
                alert('正しい金額を入力してください');
                return false;
            }

            $.ajax({
                url: $(this).attr('action'),
                method: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    // モーダルを閉じる
                    $('#addSpendingModal').modal('hide');

                    // カレンダーを更新
                    calendarInstance.loadData();
                },
                error: function() {
                    alert('登録に失敗しました');
                }
            });
        });

        // フォームの送信イベント
        $('#spendingForm').on('submit', function() {
            let amount = $('#amount').val();
            $('#amount').val(amount.replace(/,/g, ''));
        });

        window.routes = {
            moneyJson: "{{ route('money.json') }}"
        };

        // インスタンス生成の修正
        var calendarInstance = $('#mini-calendar').miniCalendar({
            api: true,
            jsonUrl: window.routes.moneyJson  // APIのURLを設定
        });

        // 前月ボタンイベント
        $('#prevMonth').click(function() {
            // 現在の年月から前月の日付を計算
            const currentDate = new Date(calendarInstance.year, calendarInstance.month - 1, 1);
            const prevMonthDate = new Date(currentDate.setMonth(currentDate.getMonth() - 1));

            // 前月の日付を YYYY-MM-DD 形式にフォーマット
            const formattedDate = `${prevMonthDate.getFullYear()}-${String(prevMonthDate.getMonth() + 1).padStart(2, '0')}-01`;

            // デバッグ用ログ
            console.log('Moving to date:', formattedDate);

            // カレンダーの更新を呼び出し
            calendarInstance.loadData(formattedDate);
        });

        // 翌月ボタンイベント（修正版）
        $('#nextMonthLink').click(function() {
            const currentDate = new Date(calendarInstance.year, calendarInstance.month - 1, 1);
            const nextMonthDate = new Date(currentDate.setMonth(currentDate.getMonth() + 1));

            const formattedDate = `${nextMonthDate.getFullYear()}-${String(nextMonthDate.getMonth() + 1).padStart(2, '0')}-01`;

            console.log('Moving to date:', formattedDate);

            calendarInstance.loadData(formattedDate);
        });

        // カレンダーのセルクリックイベント
        $(document).on('click', 'td[id^="calender-id"]', function() {
            // デバッグログ
            console.log('Clicked cell:', this);

            // IDから日付を取得（例：calender-id1 → 1）
            const day = $(this).attr('id').replace('calender-id', '').padStart(2, '0');

            // calendar-year-monthから年月を取得
            const yearMonth = $('.calendar-year-month').text(); // 例: "2024年3月"
            const matches = yearMonth.match(/(\d{4})年(\d{1,2})月/);

            if (!matches) {
                console.error('年月の取得に失敗しました');
                return;
            }

            const year = matches[1];
            const month = matches[2].padStart(2, '0');
            const date = `${year}-${month}-${day}`;

            console.log('Constructed date:', { year, month, day, date });

            // 支出一覧を取得して表示
            $.ajax({
                url: '/money/daily/' + date,
                method: 'GET',
                success: function(data) {
                    $('#spendingListBody').empty();
                    $('#dailySpendingListLabel').text(date + ' の支出一覧');

                    data.forEach(function(spending) {
                        const row = `
                            <tr>
                                <td>${Number(spending.tgtmoney).toLocaleString()}円</td>
                                <td>${spending.description || '説明なし'}</td>
                                <td>
                                    <button class="btn btn-sm btn-primary edit-spending mr-2"
                                            data-id="${spending.id}"
                                            data-money="${spending.tgtmoney}"
                                            data-item="${spending.tgtitem}">
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
                },
                error: function(xhr, status, error) {
                    console.error('Error details:', {
                        status: status,
                        error: error,
                        response: xhr.responseText
                    });
                    alert('データの取得に失敗しました: ' + error);
                }
            });

            // 新規登録用の日付もセット
            $('#selected_date').val(date);
        });

        // 削除ボタンのクリックイベント
        $(document).on('click', '.delete-spending', function() {
            if (confirm('本当に削除しますか？')) {
                // フォーカスを解放
                $(this).blur();

                const id = $(this).data('id');
                $.ajax({
                    url: '/money/' + id,
                    method: 'DELETE',
                    data: {
                        _token: $('meta[name="csrf-token"]').attr('content')
                    },
                    success: function(response) {
                        $('#dailySpendingList').modal('hide');
                        calendarInstance.loadData();
                    },
                    error: function() {
                        alert('削除に失敗しました');
                    }
                });
            }
        });

        // 編集ボタンのクリックイベントを修正
        $(document).on('click', '.edit-spending', function() {
            const id = $(this).data('id');
            const money = $(this).data('money');
            const item = $(this).data('item');

            // フォーカスを解放
            $(this).blur();

            // 一覧モーダルを閉じる前にフォーカスを移動
            $('#dailySpendingList').one('hide.bs.modal', function() {
                setTimeout(() => {
                    // 編集フォームに値をセット
                    $('#edit_spending_id').val(id);
                    $('#edit_tgtmoney').val(money);
                    $('#edit_tgtitem').val(item);

                    // 編集モーダルを表示
                    $('#editSpendingModal').modal('show');

                    // 編集モーダルが表示された後にフォーカスを設定
                    $('#editSpendingModal').one('shown.bs.modal', function() {
                        $('#edit_tgtmoney').focus();
                    });
                }, 150);
            });

            // 一覧モーダルを閉じる
            $('#dailySpendingList').modal('hide');
        });

        // 保存ボタンのクリックイベント
        $('#saveEdit').on('click', function() {
            const id = $('#edit_spending_id').val();
            const data = {
                tgtmoney: $('#edit_tgtmoney').val(),
                tgtitem: $('#edit_tgtitem').val(),
                _token: $('meta[name="csrf-token"]').attr('content')
            };

            $.ajax({
                url: '/money/' + id,
                method: 'PUT',
                data: data,
                success: function(response) {
                    // 両方のモーダルを閉じる
                    $('#editSpendingModal').modal('hide');
                    $('#dailySpendingList').modal('hide');

                    // カレンダーを更新
                    calendarInstance.loadData();
                },
                error: function() {
                    alert('更新に失敗しました');
                }
            });
        });

        // 一覧の更新用関数
        function updateSpendingList(data, date) {
            $('#spendingListBody').empty();
            $('#dailySpendingListLabel').text(date + ' の支出一覧');

            data.forEach(function(spending) {
                const row = `
                    <tr>
                        <td>${Number(spending.tgtmoney).toLocaleString()}円</td>
                        <td>${spending.description || '説明なし'}</td>
                        <td>
                            <button class="btn btn-sm btn-primary edit-spending mr-2"
                                    data-id="${spending.id}"
                                    data-money="${spending.tgtmoney}"
                                    data-item="${spending.tgtitem}">
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

        // 新規ボタンのクリックイベントを修正
        $(document).on('click', '#new-spending-btn', function() {
            // 今日の日付をデフォルトとしてセット
            const today = new Date();
            const year = today.getFullYear();
            const month = (today.getMonth() + 1).toString().padStart(2, '0');
            const day = today.getDate().toString().padStart(2, '0');
            const date = `${year}-${month}-${day}`;

            // 選択された日付をフォームにセット
            $('#selected_date').val(date);

            // 新規登録モーダルを表示
            $('#addSpendingModal').modal('show');
        });

        // モーダルが閉じられる前のイベント
        $('#dailySpendingList, #editSpendingModal').on('hide.bs.modal', function() {
            // モーダル内の全てのフォーカス可能な要素からフォーカスを解放
            $(this).find('button, input, select, textarea').blur();
        });
      });
    </script>
  </body>
</html>
<!-- 支出データ一覧モーダル -->
<div class="modal fade"
     id="dailySpendingList"
     tabindex="-1"
     role="dialog"
     aria-labelledby="dailySpendingListLabel"
     data-backdrop="static"
     data-keyboard="false">
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
<!-- 支出一覧モーダルの後に配置 -->
<div class="modal fade"
     id="editSpendingModal"
     tabindex="-1"
     role="dialog"
     aria-labelledby="editSpendingModalLabel"
     data-backdrop="static"
     data-keyboard="false">
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
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">キャンセル</button>
                <button type="button" class="btn btn-primary" id="saveEdit">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 新規登録モーダル -->
<div class="modal fade" id="addSpendingModal" tabindex="-1" role="dialog" aria-labelledby="addSpendingModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addSpendingModalLabel">支出の登録</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="addSpendingForm" method="POST" action="{{ route('money.store') }}">
                    @csrf
                    <div class="form-group">
                        <label for="date">日付</label>
                        <input type="date"
                               class="form-control"
                               id="selected_date"
                               name="date"
                               required
                               value="{{ date('Y-m-d') }}">
                    </div>
                    <div class="form-group">
                        <label for="amount">金額</label>
                        <input type="text"
                               class="form-control"
                               id="amount"
                               name="amount"
                               required
                               pattern="[0-9]*"
                               inputmode="numeric"
                               placeholder="金額を入力してください">
                    </div>
                    <div class="form-group">
                        <label for="tgtitem">項目</label>
                        <select class="form-control" id="tgtitem" name="tgtitem" required>
                            <option value="1">食費</option>
                            <option value="2">日用品</option>
                            <option value="3">衣服</option>
                            <option value="4">交通費</option>
                            <option value="5">その他</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="description">説明</label>
                        <input type="text" class="form-control" id="description" name="description">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">キャンセル</button>
                        <button type="submit" class="btn btn-primary">登録</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
