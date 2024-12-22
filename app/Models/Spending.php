<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Spending extends Model
{
    protected $table = 'spendings';
    
    protected $fillable = [
        'tgtdate',
        'tgtmoney',
        'tgtitem'
    ];

    protected $dates = [
        'tgtdate'
    ];
}
