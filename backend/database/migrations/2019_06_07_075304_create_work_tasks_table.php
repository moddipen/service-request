<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateWorkTasksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('work_tasks', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('title');
            $table->text('description')->nullable();
            $table->unsignedBigInteger('work_order_id');
            $table->unsignedInteger('work_category_id');
            $table->unsignedInteger('work_priority_id');
            $table->morphs('added_by');
            $table->text('company_notes')->nullable();
            $table->text('contractor_notes')->nullable();
            $table->timestamps();

            $table->foreign('work_order_id')->references('id')->on('work_orders')->onDelete('cascade');
            $table->foreign('work_category_id')->references('id')->on('work_categories')->onDelete('cascade');
            $table->foreign('work_priority_id')->references('id')->on('work_priorities')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('work_tasks');
    }
}
