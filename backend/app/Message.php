<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Message extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'ship_id', 'content', 'row', 'col',
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
        'ship_id' => 'integer',
        'row' => 'integer',
        'col' => 'integer'
    ];

    public function ship()
    {
        return $this->belongsTo('App\Ship');
    }
}
