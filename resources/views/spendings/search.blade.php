@extends('layouts.app')

@section('content')
<div class="container">
    <h1 class="title">検索結果: "{{ $keyword }}"</h1>
    <div class="box">
        <p class="is-size-4">合計金額: {{ number_format($totalAmount) }}円</p>
    </div>

    <table class="table is-fullwidth">
        <thead>
            <tr>
                <th>日付</th>
                <th>説明</th>
                <th>金額</th>
            </tr>
        </thead>
        <tbody>
            @foreach($spendings as $spending)
                <tr>
                    <td>{{ $spending->created_at->format('Y-m-d') }}</td>
                    <td>{{ $spending->description }}</td>
                    <td>{{ number_format($spending->tgtmoney) }}円</td>
                </tr>
            @endforeach
        </tbody>
    </table>
</div>
@endsection
