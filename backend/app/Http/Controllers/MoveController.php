<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

use App\Ship;
use App\User;

/**
 * Handles all the steps to allow someone to join the game
 */
class MoveController extends Controller
{
    public function __construct()
    {
        $this->middleware('validated');
    }

    /**
     * Move player's ship in a particular direction
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function index($token, User $user, $direction)
    {
        dd($direction);

        return [
            'user' => $user
        ];
    }
}