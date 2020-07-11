<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

use App\Ship;
use App\User;

/**
 * Handles all the steps to allow someone to join the game
 */
class InteractionController extends Controller
{
    public function __construct()
    {
        $this->middleware('validated');
    }

    /**
     * Move player's ship in a particular direction
     *
     * @return \Illuminate\Http\Response
     */
    public function move($direction, User $user, $token)
    {
        $ship = $user->ship;

        switch($direction) {
            case 'up': $ship->row -= 1; break;
            case 'down': $ship->row += 1; break;
            case 'left': $ship->col -= 1; break;
            case 'right': $ship->col += 1; break;
            default:
                throw new \Exception('Unknown move direction: ' + $direction);
        }

        $ship->save();
        
        return [
            'ship' => $ship
        ];
    }

    /**
     * Send a message
     *
     * @return \Illuminate\Http\Response
     */
    public function message($content, User $user, $token)
    {
        dd($content);

        return [
            'user' => $user
        ];
    }

    /**
     * Send a message
     *
     * @return \Illuminate\Http\Response
     */
    public function sync(User $user, $token)
    {
        return [
            'user' => $user
        ];
    }
}