<?php

use Illuminate\Http\Request;

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

/**
 * Get all subscription plans
 */
Route::get('subscription-plans', 'GeneralController@getSubscriptionPlan');

/**
 * User auth routes
 */
Route::post('login', 'Auth\UserController@login');
Route::post('sign-up', 'Auth\UserController@signUp');
Route::post('forget-password', 'Auth\UserController@forgetPassword');
Route::post('reset-password', 'Auth\UserController@resetPassword');

/**
 * Admin login
 */
Route::post('admin/login', 'Auth\AdminController@login');
Route::get('admin/test', 'Auth\AdminController@login');

/**
 * Site settings route
 */
Route::get('settings', 'GeneralController@getSettings');

/**
 * Work priorities route
 */
Route::get('priorities', 'GeneralController@getWorkPriorities');

/**
 * Set account details from invitation
 */
Route::post('set-account', 'GeneralController@setAccountPassword');