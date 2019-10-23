<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| Company API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

/**
 * User routes
 */
Route::get('/profile', 'UserController@getAuthUserDetails');
Route::post('/change-password', 'UserController@changePassword');
Route::post('/update-profile', 'UserController@update');
Route::post('/invite-users', 'UserController@inviteUser');
Route::get('/users/editors', 'UserController@getCompanyEditors');
Route::get('/users/contractors', 'UserController@getContractors');
Route::get('/users/site-admins', 'UserController@getSiteAdmin');
Route::get('/users/site-staff', 'UserController@getSiteStaff');
Route::get('roles', 'UserController@rolesAndPermissions');
Route::put('/users/permission/update/{id}', 'UserController@updateUserPermissions');
Route::put('/users/update/{id}', 'UserController@updateUser');
Route::put('/users/delete/{id}', 'UserController@deleteUser');

/**
 * Subscription routes
 */
Route::get('/subscriptions/cancel', 'PaymentController@cancelSubscription');
Route::get('/subscriptions/resume', 'PaymentController@resumeSubscription');
Route::post('/subscriptions/update', 'PaymentController@updateSubscription');
Route::post('/subscriptions/card/update', 'PaymentController@updateCardDetails');
Route::get('/subscriptions/invoices', 'PaymentController@invoices');
Route::get('/subscriptions/current', 'PaymentController@getSubscriptionDetails');

/**
 * Site locations routes
 */
Route::resource('locations', 'SiteLocationController')->except([
    'create', 'show', 'edit'
]);

/**
 * Work categories routes
 */
Route::resource('categories', 'WorkCategoryController')->except([
    'create', 'show', 'edit'
]);

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
Route::post('work-orders/tasks/comments/update', 'WorkOrderController@updateComment');
Route::delete('/work-orders/photo/delete/{id}', 'WorkOrderController@deletePhoto');
Route::delete('/work-orders/task/photo/delete/{id}', 'WorkOrderController@deleteTaskPhoto');
Route::post('/work-orders/tasks/edit/{id}', 'WorkOrderController@updateTask');