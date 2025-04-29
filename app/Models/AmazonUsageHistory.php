<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AmazonUsageHistory extends Model
{
    use HasFactory;

    protected $table    = 'amazon_usage_history';
    protected $fillable = ['date', 'is_used'];
}
