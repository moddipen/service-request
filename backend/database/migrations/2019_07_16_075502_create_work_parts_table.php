<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateWorkPartsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('work_parts', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('work_order_id');
            $table->string('name');
            $table->double('price', 8, 2);
            $table->morphs('added_by');
            $table->timestamps();
            $table->foreign('work_order_id')->references('id')->on('work_orders')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('work_parts');
    }
}
