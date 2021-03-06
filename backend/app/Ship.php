<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Ship extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'user_id', 'row', 'col',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'user_id' => 'integer',
        'row' => 'integer',
        'col' => 'integer'
    ];

    public function user()
    {
        return $this->belongsTo('App\User');
    }
}
