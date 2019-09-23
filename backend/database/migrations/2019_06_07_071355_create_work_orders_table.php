<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateWorkOrdersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('work_orders', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('title');
            $table->text('description')->nullable();
            $table->string('service_request_id')->unique();
            $table->string('purchase_order_number')->default('');
            $table->unsignedBigInteger('site_location_id');
            $table->morphs('order_by');
            $table->tinyInteger('order_priority_id')->default(0);
            $table->tinyInteger('quote_required')->default(0);
            $table->tinyInteger('contractor_quote_required')->default(0);
            $table->unsignedBigInteger('assign_to')->default(0);
            $table->double('contractor_cost', 8, 2)->default(0.00);
            $table->double('company_cost', 8, 2)->default(0.00);
            $table->tinyInteger('status')->default(0)->comment('0 = Processing, 1 = Closed, 2 = Completed');
            $table->timestamps();

            $table->foreign('site_location_id')->references('id')->on('site_locations')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('work_orders');
    }
}
