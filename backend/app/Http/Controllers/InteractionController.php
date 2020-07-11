<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

use Validator;
use App\Ship;
use App\User;
use App\Message;

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
        $ship = $user->ship;

        Validator::make(['content' => $content], [
            'content' =>  'required|max:8',
        ])->validate();

        $message = Message::create([
            'ship_id' => $ship->id,
            'content' => $content,
            'row' => $ship->row,
            'col' => $ship->col
        ]);

        return [
            'message' => $message
        ];
    }

    /**
     * Send a message
     *
     * @return \Illuminate\Http\Response
     */
    public function sync(User $user, $token)
    {
        $reach = config('game.message_quadrants_reach', 10);
        $maxReceive = config('game.message_max_receive', 50);

        $ship = $user->ship;

        $filter = [
            ['ship_id', '!=', $ship->id], // exclude own ship messages
            ['row', '>=', $ship->row - $reach],
            ['row', '<=', $ship->row + $reach],
            ['col', '>=', $ship->col - $reach],
            ['col', '<=', $ship->col + $reach],
        ];

        $messages = Message::where($filter)
                        ->orderBy('created_at', 'asc')
                        ->take(30)
                        ->get();

        return [
            'user' => $user,
            'messages' => $messages
        ];
    }
}