<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Str;

use Validator;
use App\Ship;
use App\User;

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
        $name = $request->get('name', 'Player' . Str::random(8)); 
        $country = $request->get('country', '?');

        return $this->create($name, $country);
    }

    /**
     * Create a new user (and required things to join the game).
     *
     * @return \Illuminate\Http\Response
     */
    public function create($name, $country)
    {
        // Variation of ship position
        $range = config('game.ship_start_quadrant_range', 30);

        $input = [
            'name' => $name,
            'country' => $country,
            'token' => Str::random(32)
        ];

        Validator::make($input, [
            'name' =>  'required|unique:users',
            'country' =>  'required|max:2',
        ])->validate();

        $user = User::create($input);

        $user->ship = Ship::create([
            'user_id' => $user->id,
            'row' => rand(-$range, $range),
            'col' => rand (-$range, $range)
        ]);

        return [
            'user' => $user
        ];
    }
}