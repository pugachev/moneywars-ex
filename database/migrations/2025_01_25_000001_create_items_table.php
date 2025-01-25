<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('items', function (Blueprint $table) {
            $table->integer('code')->primary();
            $table->text('name');
        });
    }

    public function down()
    {
        Schema::dropIfExists('items');
    }
};
