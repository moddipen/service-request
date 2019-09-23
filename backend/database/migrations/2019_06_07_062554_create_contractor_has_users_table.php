<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateContractorHasUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('contractor_has_users', function (Blueprint $table) {
            $table->unsignedBigInteger('contractor_user_id');
            $table->unsignedBigInteger('user_id');

            $table->foreign('contractor_user_id')->references('id')->on('contractor_users')->onDelete('cascade');
            $table->foreign('user_id')->references('id')->on('contractor_users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('contractor_has_users');
    }
}
