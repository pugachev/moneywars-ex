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
    <title>moneywars</title>
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

        .calendar-head {
            text-align: center;
            margin-bottom: 20px;
        }
        .calendar-header-content {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 5px;
        }
        .calendar-year-month {
            font-size: 24px;
            font-weight: bold;
            margin: 0;
        }
        .monthly-total {
            font-size: 16px;
            color: #dc3545;
            margin: 0 0 10px 0;
        }
        /* 新規ボタンの無効化状態のスタイル */
        .nav-link.disabled {
            opacity: 0.6;
            pointer-events: none;
        }
        /* 新規ボタンの無効化状態のスタイル */
        .nav-link.disabled {
            opacity: 0.6;
            pointer-events: none;
        }
    </style>
  </head>
  <body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-info sticky-top mb-0">
        <a class="navbar-brand" href="{{route('money.index')}}">moneywars</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <!-- 左側のナビゲーション -->
            <ul class="navbar-nav d-flex align-items-center">
                <li class="nav-item active d-flex align-items-center">
                    <span>
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#addSpendingModal" style="color: #ffffff;font-weight: bold;">
                            新規
                        </a>
                    </span>
                    <!-- 月間目標値を新規作成の隣に配置 -->
                    <span class="ml-3 navbar-text" style="color: #ffffff;font-weight: bold;">月間目標 : 100000円</span>
                    <!-- 月間実測値を月間目標値の隣に配置 -->
                    <span class="ml-3 navbar-text" style="color: #000000;font-weight: bold;"><a id="prevMonth" class="btn btn-light btn-sm" style="color: black;">前月</a></span>
                    <span class="ml-3 navbar-text" style="color: #000000;font-weight: bold;"><a id="nextMonthLink" class="btn btn-light btn-sm" style="color: black;">翌月</a></span>
                    <!-- 検索フォームを追加 -->
                    <form action="{{ route('money.search') }}" method="GET" class="ml-3 d-flex align-items-center">
                        <input type="text"
                               name="keyword"
                               class="form-control form-control-sm"
                               placeholder="説明文で検索"
                               style="width: 200px;">
                        <button type="submit"
                                class="btn btn-light btn-sm ml-2">
                            検索
                        </button>
                    </form>
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

      const ITEM_NAMES = {
        1: '食費',
        2: '日用品',
        3: '衣服',
        4: '交通費',
        5: 'その他'
      };

      const MESSAGES = {
          success: {
              update: '更新しました',
              delete: '削除しました'
          },
          error: {
              fetch: 'データの取得に失敗しました',
              update: '更新に失敗しました',
              delete: '削除に失敗しました'
          }
      };

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

        // モーダルが閉じられる前のイベント
        $('#dailySpendingList, #editSpendingModal, #addSpendingModal').on('hide.bs.modal', function() {
            // モーダル内の全てのフォーカス可能な要素からフォーカスを解放
            $(this).find('button, input, select, textarea').blur();
        });

        // モーダルが閉じられる前のイベント
        $('#dailySpendingList, #editSpendingModal, #addSpendingModal').on('hide.bs.modal', function() {
            // モーダル内の全てのフォーカス可能な要素からフォーカスを解放
            $(this).find('button, input, select, textarea').blur();
        });

        // モーダルが閉じられた時のイベント
        $('#addSpendingModal').on('hidden.bs.modal', function () {
            // フォームをリセット
            $('#addSpendingForm')[0].reset();
            $('#selected_date').val('');
            // フォーカスを解放
            $(this).find('button, input, select, textarea').blur();
        });

        // モーダルが開く前のイベント
        $('#dailySpendingList, #editSpendingModal, #addSpendingModal').on('show.bs.modal', function() {
            // 他のモーダルを確実に閉じる
            $('.modal').not(this).modal('hide');
        });

        // フォーカス管理の改善
        $('.modal').on('shown.bs.modal', function() {
            // モーダルが表示された後、最初のフォーカス可能な要素にフォーカスを設定
            $(this).find('input:visible, select:visible, textarea:visible').first().focus();
            // フォーカスを解放
            $(this).find('button, input, select, textarea').blur();
        });

        // モーダルが開く前のイベント
        $('#dailySpendingList, #editSpendingModal, #addSpendingModal').on('show.bs.modal', function() {
            // 他のモーダルを確実に閉じる
            $('.modal').not(this).modal('hide');
        });

        // フォーカス管理の改善
        $('.modal').on('shown.bs.modal', function() {
            // モーダルが表示された後、最初のフォーカス可能な要素にフォーカスを設定
            $(this).find('input:visible, select:visible, textarea:visible').first().focus();
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
            moneyJson: "{{ route('money.json') }}",
            moneyDaily: "{{ url('money/daily') }}/",
            moneyDestroy: "{{ url('money') }}/",
            moneyUpdate: "{{ url('money') }}/"
        };

        // 月間目標値を定数として定義
        const MONTHLY_TARGET = 100000;

        // 新規ボタンの状態を更新する関数を修正
        function updateNewButtonState(monthlyTotal) {
            console.log('Updating new button state with monthly total:', monthlyTotal);

            // data-target属性を削除せずにセレクタを使用
            const newButton = $('a.nav-link[data-target="#addSpendingModal"]');

            console.log('All possible new buttons found:', {
                count: newButton.length,
                elements: newButton.toArray().map(el => ({
                    tagName: el.tagName,
                    classes: el.className,
                    attributes: {
                        dataToggle: $(el).attr('data-toggle'),
                        dataTarget: $(el).attr('data-target')
                    },
                    html: el.outerHTML
                }))
            });

            if (newButton.length === 0) {
                console.error('New spending button not found!');
                // ボタンが見つからない場合は、より広範なセレクタで再試行
                const altButton = $('a.nav-link').first();
                if (altButton.length > 0) {
                    console.log('Found button with alternative selector');
                    // 必要な属性を復元
                    altButton.attr('data-target', '#addSpendingModal')
                            .attr('data-toggle', 'modal');
                    return updateNewButtonState(monthlyTotal); // 再帰的に呼び出し
                }
                return;
            }

            // 数値として比較するために変換
            const total = Number(monthlyTotal);
            console.log('Comparing total:', total, 'with target:', MONTHLY_TARGET);

            if (total >= MONTHLY_TARGET) {
                console.log('Disabling new button - monthly total exceeds target');
                newButton.addClass('disabled')
                        .css('cursor', 'not-allowed')
                        .attr('title', '今月の支出が目標額を超えています')
                        // data-toggle と data-target は維持
                        .attr('data-toggle', 'modal')
                        .attr('data-target', '#addSpendingModal');
            } else {
                console.log('Enabling new button');
                newButton.removeClass('disabled')
                        .removeAttr('disabled')
                        .css('cursor', 'pointer')
                        .attr('title', '')
                        .attr('data-toggle', 'modal')
                        .attr('data-target', '#addSpendingModal');
            }

            // 更新後の状態を確認
            console.log('Button after update:', {
                hasDisabledClass: newButton.hasClass('disabled'),
                dataToggle: newButton.attr('data-toggle'),
                dataTarget: newButton.attr('data-target'),
                element: newButton[0]
            });
        }

        // カレンダーインスタンス生成時の処理を修正
        var calendarInstance = $('#mini-calendar').miniCalendar({
            api: true,
            jsonUrl: window.routes.moneyJson,
            onDataLoaded: function(data) {
                // デバッグログを追加
                console.log('Calendar data loaded:', data);

                // データロード後に月間合計を計算して新規ボタンの状態を更新
                if (data && data.monthlyTotal) {
                    console.log('Monthly total:', data.monthlyTotal);
                    updateNewButtonState(data.monthlyTotal);
                } else {
                    console.log('Monthly total not found in data');
                }
            }
        });

        // データ取得後の処理を追加
        $(document).off('calendarDataLoaded').on('calendarDataLoaded', function(e, data) {
            console.log('Calendar data loaded event:', data);

            // monthlyTotalが0または未定義の場合も含めて必ず処理を実行
            const total = data && data.monthlyTotal ? Number(data.monthlyTotal) : 0;
            console.log('Processing monthly total:', total);

            // 必ず updateNewButtonState を呼び出す
            updateNewButtonState(total);
        });

        // 前月ボタンイベント
        $('#prevMonth').click(function() {
            // 現在の年月から前月の日付を計算
            const currentDate = new Date(calendarInstance.year, calendarInstance.month - 1, 1);
            const prevMonthDate = new Date(currentDate.setMonth(currentDate.getMonth() - 1));

            // 前月の日付を YYYY-MM-DD 形式にフォーマット
            const formattedDate = `${prevMonthDate.getFullYear()}-${String(prevMonthDate.getMonth() + 1).padStart(2, '0')}-01`;

            // カレンダーの更新を呼び出し
            calendarInstance.loadData(formattedDate);
        });

        // 翌月ボタンイベント
        // 翌月ボタンイベント
        $('#nextMonthLink').click(function() {
            const currentDate = new Date(calendarInstance.year, calendarInstance.month - 1, 1);
            const nextMonthDate = new Date(currentDate.setMonth(currentDate.getMonth() + 1));

            const formattedDate = `${nextMonthDate.getFullYear()}-${String(nextMonthDate.getMonth() + 1).padStart(2, '0')}-01`;

            calendarInstance.loadData(formattedDate);
        });

        // カレンダーのセルクリックイベント
        $(document).on('click', 'td[id^="calender-id"]', function() {
            console.log('Clicked cell:', this);

            const date = $(this).attr('id').replace('calender-id', '').padStart(2, '0');
            const yearMonth = $('.calendar-year-month').text();
            const matches = yearMonth.match(/(\d{4})年(\d{1,2})月/);

            if (!matches) {
                console.error('年月の取得に失敗しました');
                return;
            }

            const year = matches[1];
            const month = matches[2].padStart(2, '0');
            const fullDate = `${year}-${month}-${date}`;

            // URLを構築（末尾にスラッシュがあるので直接結合可能）
            const url = window.routes.moneyDaily + fullDate;

            $.ajax({
                url: url,
                method: 'GET',
                dataType: 'json',
                success: function(data) {
                    console.log('Success:', data);
                    updateSpendingList(data, fullDate);
                },
                error: function(xhr, status, error) {
                    console.error('Error details:', {
                        status: status,
                        error: error,
                        response: xhr.responseText
                    });
                    alert('データの取得に失敗しました');
                }
            });
        });

        // 削除ボタンのクリックイベント
        $(document).on('click', '.delete-spending', function() {
            if (confirm('本当に削除しますか？')) {
                $(this).blur();

                const id = $(this).data('id');
                $.ajax({
                    url: window.routes.moneyDestroy + id,
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
            const description = $(this).data('description');

            $('#edit_spending_id').val(id);
            $('#edit_tgtmoney').val(money);
            $('#edit_tgtitem').val(item);
            $('#edit_description').val(description);

            $('#editSpendingModal').modal('show');
        });

        // 保存ボタンのクリックイベントを修正
        $('#saveEdit').on('click', function() {
            const id = $('#edit_spending_id').val();
            const data = {
                tgtmoney: $('#edit_tgtmoney').val(),
                tgtitem: $('#edit_tgtitem').val(),
                description: $('#edit_description').val(),
                _token: $('meta[name="csrf-token"]').attr('content')
            };

            $.ajax({
                url: window.routes.moneyUpdate + id,
                method: 'PUT',
                data: data,
                success: function(response) {
                    $('#editSpendingModal').modal('hide');

                    // 一覧を再読み込み
                    const date = $('#dailySpendingListLabel').text().split(' ')[0];
                    $.ajax({
                        url: window.routes.moneyDaily + date,
                        method: 'GET',
                        success: function(data) {
                            $('#spendingListBody').empty();

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

                            // カレンダーも更新
                            calendarInstance.loadData();
                        },
                        error: function() {
                            alert('データの取得に失敗しました');
                        }
                    });
                },
                error: function() {
                    alert('更新に失敗しました');
                }
            });
        });

        // 一覧の更新用関数を修正
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

        // jQueryの設定
        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }
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
                        <input type="number"
                               class="form-control"
                               id="edit_tgtmoney"
                               required
                               style="-webkit-appearance: none; margin: 0;"
                               onwheel="return false;">
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
