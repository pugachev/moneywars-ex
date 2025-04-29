@extends('layouts.app')

@section('content')
<meta name="csrf-token" content="{{ csrf_token() }}">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <a href="{{ route('amazon.index', ['date' => $currentDate->copy()->subMonth()->format('Y-m-d')]) }}" class="btn btn-primary">前月</a>
                    <h3 class="mb-0">{{ $currentDate->format('Y年n月') }}</h3>
                    <a href="{{ route('amazon.index', ['date' => $currentDate->copy()->addMonth()->format('Y-m-d')]) }}" class="btn btn-primary">翌月</a>
                </div>

                <div class="card-body">
                    <div class="calendar">
                        <table class="table table-bordered mb-0">
                            <thead>
                                <tr>
                                    @foreach(['日', '月', '火', '水', '木', '金', '土'] as $dayOfWeek)
                                        <th class="text-center" style="width: 14.28%">
                                            <span class="{{ $dayOfWeek === '日' ? 'text-danger' : ($dayOfWeek === '土' ? 'text-primary' : '') }}">
                                                {{ $dayOfWeek }}
                                            </span>
                                        </th>
                                    @endforeach
                                </tr>
                            </thead>
                            <tbody>
                                @php
                                    $startDay = $currentDate->copy()->startOfMonth()->startOfWeek(Carbon\Carbon::SUNDAY);
                                    $endDay = $currentDate->copy()->endOfMonth()->endOfWeek(Carbon\Carbon::SATURDAY);
                                    $currentMonth = $currentDate->format('m');
                                @endphp

                                @while ($startDay <= $endDay)
                                    <tr>
                                        @for ($i = 0; $i < 7; $i++)
                                            @php
                                                $dateStr = $startDay->format('Y-m-d');
                                                $isCurrentMonth = $startDay->format('m') === $currentMonth;
                                                $status = 'none';
                                                if ($isCurrentMonth && isset($usageHistory[$dateStr])) {
                                                    $status = $usageHistory[$dateStr]->is_used ? 'ok' : 'ng';
                                                }
                                            @endphp
                                            <td class="text-center p-0" style="height: 50px; position: relative;">
                                                @if ($isCurrentMonth)
                                                    <button class="btn date-btn w-100 h-100 border-0"
                                                            data-date="{{ $dateStr }}"
                                                            data-status="{{ $status }}">
                                                        <div class="position-relative w-100 h-100">
                                                            <span class="position-absolute" style="top: 5px; left: 5px;">
                                                                {{ $startDay->format('j') }}
                                                            </span>
                                                            <span class="usage-mark position-absolute" style="top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 20px;">
                                                                @if ($status === 'ok')
                                                                    ○
                                                                @elseif ($status === 'ng')
                                                                    ×
                                                                @endif
                                                            </span>
                                                        </div>
                                                    </button>
                                                @else
                                                    <span class="text-muted">{{ $startDay->format('j') }}</span>
                                                @endif
                                            </td>
                                            @php
                                                $startDay->addDay();
                                            @endphp
                                        @endfor
                                    </tr>
                                @endwhile
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.date-btn {
    background-color: white !important;
    padding: 0 !important;
}

.date-btn:hover {
    background-color: #f8f9fa !important;
}

.usage-mark {
    opacity: 0.7;
}

.date-btn[data-status="ok"] .usage-mark {
    color: #28a745;
}

.date-btn[data-status="ng"] .usage-mark {
    color: #dc3545;
}
</style>

@push('scripts')
<script>
// 状態の定数
const STATUS = {
    OK: 'ok',
    NG: 'ng',
    NONE: 'none'
};

// APIのベースURL
const BASE_URL = '{{ url("/") }}';

// 状態に応じたマークの設定
const STATUS_MARKS = {
    [STATUS.OK]: { text: '○', color: '#28a745' },
    [STATUS.NG]: { text: '×', color: '#dc3545' },
    [STATUS.NONE]: { text: '', color: '' }
};

// ボタンの状態を更新する関数
function updateButtonStatus(button, status) {
    const mark = button.querySelector('.usage-mark');
    const statusConfig = STATUS_MARKS[status];

    mark.textContent = statusConfig.text;
    mark.style.color = statusConfig.color;
    button.dataset.status = status;
}

// エラーメッセージを表示する関数
function showError(message) {
    // Toastrが利用可能な場合
    if (typeof toastr !== 'undefined') {
        toastr.error(message);
    } else {
        alert(message);
    }
}

document.querySelectorAll('.date-btn').forEach(button => {
    button.addEventListener('click', async function() {
        const date = this.dataset.date;
        try {
            button.disabled = true; // 二重クリック防止

            const response = await fetch(`${BASE_URL}/amazon/toggle`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    'X-CSRF-TOKEN': '{{ csrf_token() }}'
                },
                body: JSON.stringify({ date })
            });

            if (!response.ok) {
                throw new Error(`サーバーエラーが発生しました。(${response.status})`);
            }

            const data = await response.json();
            if (data.success) {
                updateButtonStatus(this, data.status);
            } else {
                throw new Error(data.message || '更新に失敗しました。');
            }
        } catch (error) {
            console.error('Error:', error);
            showError(error.message);
        } finally {
            button.disabled = false;
        }
    });
});
</script>
@endpush
@endsection
