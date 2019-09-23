<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSiteLocationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('site_locations', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('company_user_id');
            $table->string('street');
            $table->string('city');
            $table->string('postal_code');
            $table->string('email');
            $table->string('phone_number');
            $table->timestamps();

            $table->foreign('company_user_id')->references('id')->on('company_users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('site_locations');
    }
}
