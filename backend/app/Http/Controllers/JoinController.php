<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

use App\Item;
use App\Message;
use App\Ship;
use App\User;
use Illuminate\Support\Str;

/**
 * Handles all the steps to allow someone to join the game
 */
class JoinController extends Controller
{
    /**
     * Create a new user (and required things to join the game).
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'country' => 'required',
        ]);

        $user = User::create([
            'name' => $request->get('name'),
            'country' => $request->get('country'),
            'token' => Str::random(32)
        ]);

        $ship = Ship::create([
            'user_id' => $user->id,
            'row' => 0, // TODO: randomize this
            'col' => 0  // TODO: randomize this
        ]);

        return [
            'user' => $user,
            'ship' => $ship,
        ];
    }
}