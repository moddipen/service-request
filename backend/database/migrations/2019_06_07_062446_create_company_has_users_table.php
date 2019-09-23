<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCompanyHasUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('company_has_users', function (Blueprint $table) {
            $table->unsignedBigInteger('company_user_id');
            $table->unsignedBigInteger('user_id');

            $table->foreign('company_user_id')->references('id')->on('company_users')->onDelete('cascade');
            $table->foreign('user_id')->references('id')->on('company_users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('company_has_users');
    }
}
