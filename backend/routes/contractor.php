<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| Contractor API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::get('/contractor', function (Request $request) {
    return $request->user();
});

Route::get('orders', 'WorkOrderController@getWorkOrders');

/**
 * Users routes
 */
Route::get('/profile', 'UserController@getAuthUserDetails');
Route::post('/change-password', 'UserController@changePassword');
Route::post('/update-profile', 'UserController@update');
Route::post('/invite-users', 'UserController@inviteUser');
Route::get('roles', 'UserController@rolesAndPermissions');
Route::put('/users/permission/update/{id}', 'UserController@updateUserPermissions');
Route::put('/users/update/{id}', 'UserController@updateUser');
Route::put('/users/delete/{id}', 'UserController@deleteUser');
Route::get('/users/contractor-staff', 'UserController@getContractorStaff');


/**
 * Work orders routes
 */
Route::resource('work-orders', 'WorkOrderController')->except([
    'create', 'edit'
]);
Route::post('work-orders/tasks', 'WorkOrderController@storeTask')->name('work-orders.task.store');
Route::put('work-orders/tasks/{id}', 'WorkOrderController@updateTask')->name('work-orders.task.update');
Route::post('work-orders/tasks/comments', 'WorkOrderController@storeComment')->name('work-orders.task.comment.store');
Route::post('work-orders/parts', 'WorkOrderController@storeParts')->name('work-orders.parts.store');
Route::get('categories', 'WorkOrderController@getCategories');
Route::get('locations', 'WorkOrderController@getLocations');