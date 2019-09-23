<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateServicerequestImagesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('servicerequest_images', function (Blueprint $table) {
             $table->bigIncrements('id');
            $table->string('path');
            $table->unsignedBigInteger('service_request_id');
            $table->timestamps();

            $table->foreign('service_request_id')->references('id')->on('work_orders')->onDelete('cascade');
        });

        


    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('servicerequest_images');
    }
}
