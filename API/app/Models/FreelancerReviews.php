<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FreelancerReviews extends Model
{
    use HasFactory;

    protected $table = 'freelancer_reviews';

    public $timestamps = true; //by default timestamp false

    protected $fillable = ['uid','freelancer_id','notes','rating','status','extra_field'];

    protected $hidden = [
        'updated_at',
    ];
}