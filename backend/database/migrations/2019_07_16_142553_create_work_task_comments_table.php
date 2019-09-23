<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateWorkTaskCommentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('work_task_comments', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('work_task_id');
            $table->text('message')->nullable();
            $table->morphs('added_by');
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
        Schema::dropIfExists('work_task_comments');
    }
}
