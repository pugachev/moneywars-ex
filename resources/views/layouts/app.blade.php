<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>Moneywars</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-danger sticky-top mb-0">
        <a class="navbar-brand" href="{{route('money.index')}}">moneywars</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav d-flex align-items-center">
                <li class="nav-item active d-flex align-items-center">
                    <span>
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#addSpendingModal" style="color: #ffffff;font-weight: bold;">
                            新規
                        </a>
                    </span>
                    <span class="ml-3 navbar-text" style="color: #ffffff;font-weight: bold;">月間目標 : 100000円</span>
                    <span class="ml-3 navbar-text" style="color: #000000;font-weight: bold;">
                        <a id="prevMonth" class="btn btn-light btn-sm" style="color: black;">前月</a>
                    </span>
                    <span class="ml-3 navbar-text" style="color: #000000;font-weight: bold;">
                        <a id="nextMonthLink" class="btn btn-light btn-sm" style="color: black;">翌月</a>
                    </span>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="{{ route('money.index') }}">支出管理</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="{{ route('amazon.index') }}">Amazon利用履歴</a>
                </li>
            </ul>
        </div>
    </nav>

    <main class="py-4">
        @yield('content')
    </main>

    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js"></script>
    @stack('scripts')
</body>
</html>
