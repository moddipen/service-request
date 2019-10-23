<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| Admin API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

/**
 * Get auth user profile
 */
Route::get('/profile', 'UserController@getAuthUserDetails');

/**
 * Change password
 */
Route::post('/change-password', 'UserController@changePassword');

/**
 * Users routes
 */
Route::get('companies', 'UserController@companyUsers');
Route::post('companies/users', 'UserController@getChildUsers');
Route::get('contractors', 'UserController@contractors');
Route::post('user-status', 'UserController@activateDeactivateUser');
Route::post('users/delete', 'UserController@destroy');
Route::post('users/show', 'UserController@show');
Route::post('users/update', 'UserController@update');
Route::post('update-settings', 'UserController@updateSettings');
Route::put('/users/permission/update/{id}', 'UserController@updateUserPermissions');
Route::put('/users/update/{id}', 'UserController@updateUser');
Route::put('/users/delete/{id}', 'UserController@deleteUser');

/**
 * Role and permissions routes
 */
Route::resource('roles', 'RoleController');

/**
 * Work order routes
 */
Route::resource('work-orders', 'WorkOrderController')->except([
    'create', 'edit'
]);

Route::delete('/work-orders/photo/delete/{id}', 'WorkOrderController@deletePhoto');
Route::post('/work-orders/tasks/edit/{id}', 'WorkOrderController@updateTask');
Route::post('work-orders/tasks/comments', 'WorkOrderController@storeComment')->name('work-orders.task.comment.store');

Route::post('work-orders/tasks/comments/update', 'WorkOrderController@updateComment');
Route::get('categories', 'WorkOrderController@getCategories');
Route::post('work-orders/tasks', 'WorkOrderController@storeTask')->name('work-orders.task.store');
Route::delete('/work-orders/task/photo/delete/{id}', 'WorkOrderController@deleteTaskPhoto');