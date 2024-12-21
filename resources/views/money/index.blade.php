<?php

?>
<!doctype html>
<html lang="ja">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <meta name="base-url" content="{{ url('/') }}">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
    <title>MoneyWars</title>
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
                    <span><a class="nav-link" href="#" data-toggle="modal" data-target="#dataCreate" style="color: #ffffff;font-weight: bold;">新規</a></span>
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

            // 表示用の年月文字列を作成 (YYYY年MM月)
            const dispDate = `${prevMonthDate.getFullYear()}年${String(prevMonthDate.getMonth() + 1).padStart(2, '0')}月`;

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
      });
    </script>
  </body>
</html>
