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
Route::get('/join', 'JoinController@index')->name('join.index');
Route::get('/join/{name}/{country}', 'JoinController@index')->name('join.create');

// Interaction
Route::get('/move/{direction}/{user}/{token}', 'InteractionController@move')->name('interaction.move');
Route::get('/warp/{row}/{col}/{user}/{token}', 'InteractionController@warp')->name('interaction.warp');
Route::get('/message/{content}/{user}/{token}', 'InteractionController@message')->name('interaction.message');
Route::get('/dispose/{item}/{user}/{token}', 'InteractionController@dispose')->name('interaction.dispose');
Route::get('/collect/{user}/{token}', 'InteractionController@collect')->name('interaction.collect');
Route::get('/sync/{user}/{token}', 'InteractionController@sync')->name('interaction.sync');

// Test
Route::get('/test', 'TestController@index')->name('test.index');
Route::get('/{token}/test', 'TestController@index')->name('test.index');
