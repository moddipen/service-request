<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTaskImagesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('task_images', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('path');
            $table->unsignedBigInteger('work_task_id');
            $table->timestamps();

            $table->foreign('work_task_id')->references('id')->on('work_tasks')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('task_images');
    }
}
