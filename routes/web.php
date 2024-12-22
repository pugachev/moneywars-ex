<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MoneyController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});
Route::get('/money', [MoneyController::class, 'index'])->name('money.index');
Route::get('/money/json/{tgtdate?}', [MoneyController::class, 'getJsonData'])
    ->withoutMiddleware(['verifyCsrfToken'])
    ->name('money.json');
Route::post('/money/store', [MoneyController::class, 'store'])->name('money.store');
