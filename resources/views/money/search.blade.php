<!doctype html>
<html lang="ja">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
    <title>検索結果 - moneywars</title>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-danger sticky-top mb-4">
        <a class="navbar-brand" href="{{route('money.index')}}">moneywars</a>
    </nav>

    <div class="container">
        <div class="row mb-4">
            <div class="col">
                <h4>検索結果: "{{ $keyword }}"</h4>
                <p class="text-danger font-weight-bold">合計金額: {{ number_format($totalAmount) }}円</p>
            </div>
        </div>

        <div class="row">
            <div class="col">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>日付</th>
                            <th>金額</th>
                            <th>項目</th>
                            <th>説明</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($spendings as $spending)
                            <tr>
                                <td>{{ \Carbon\Carbon::parse($spending->tgtdate)->format('Y-m-d') }}</td>
                                <td>{{ number_format($spending->tgtmoney) }}円</td>
                                <td>
                                    @switch($spending->tgtitem)
                                        @case(1) 食費 @break
                                        @case(2) 日用品 @break
                                        @case(3) 衣服 @break
                                        @case(4) 交通費 @break
                                        @case(5) その他 @break
                                    @endswitch
                                </td>
                                <td>{{ $spending->description }}</td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>

                <!-- ページネーションの表示を中央寄せに修正 -->
                <div class="d-flex flex-column align-items-center mt-4">
                    <div class="text-muted mb-2">
                        全{{ $spendings->total() }}件中
                        {{ $spendings->firstItem() }}~{{ $spendings->lastItem() }}件を表示
                    </div>
                    <div>
                        {{ $spendings->appends(['keyword' => $keyword])->links('pagination::bootstrap-4') }}
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ページネーションのスタイルを修正 -->
    <style>
    .pagination {
        margin: 0;
        justify-content: center;
    }
    .page-item.active .page-link {
        background-color: #dc3545;
        border-color: #dc3545;
    }
    .page-link {
        color: #dc3545;
    }
    .page-link:hover {
        color: #dc3545;
    }
    .page-item.disabled .page-link {
        color: #6c757d;
    }
    </style>

    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
</body>
</html>
