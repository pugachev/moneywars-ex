<?php

use App\Http\Controllers\MoneyController;
use App\Http\Controllers\SpendingController;
use Illuminate\Support\Facades\Route;

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
Route::get('/money/daily/{date}', [MoneyController::class, 'daily'])->name('money.daily');
Route::delete('/money/{id}', [MoneyController::class, 'destroy'])->name('money.destroy');
Route::put('/money/{id}', [MoneyController::class, 'update'])->name('money.update');
Route::get('/spendings/search', [SpendingController::class, 'search'])->name('spendings.search');
Route::get('/money/search', [MoneyController::class, 'search'])->name('money.search');
Route::get('/money/graph', [MoneyController::class, 'graph'])->name('money.graph');
Route::get('/money/graph/data', [MoneyController::class, 'graphData'])->name('money.graph.data');
