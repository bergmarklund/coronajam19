<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Join
Route::post('/join', 'JoinController@index')->name('join.index');

// Test
Route::get('/test', 'TestController@index')->name('test.index');
Route::get('/{token}/test', 'TestController@index')->name('test.index');
