<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('spendings', function (Blueprint $table) {
            $table->id();
            $table->date('tgtdate');
            $table->integer('tgtmoney');
            $table->integer('tgtitem');
            $table->string('description')->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('spendings');
    }
};
