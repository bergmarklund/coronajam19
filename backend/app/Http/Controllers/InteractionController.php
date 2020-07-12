<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Arr;

use Validator;
use App\Ship;
use App\User;
use App\Message;
use App\Item;

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
            'action' => 'move',
            'ship' => $ship
        ];
    }

    /**
     * Move player's ship in a particular direction
     *
     * @return \Illuminate\Http\Response
     */
    public function warp($row, $col, User $user, $token)
    {
        $inputs = [
            'row' => $row,
            'col' => $col,
        ];

        Validator::make($inputs, [
            'row' =>  'required|integer',
            'col' =>  'required|integer',
        ])->validate();

        $ship = $user->ship;
        $ship->row = $row;
        $ship->col = $col;

        $ship->save();
        
        return [
            'action' => 'warp',
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
            'action' => 'message',
            'message' => $message
        ];
    }

    protected function findNeighborShips($ship)
    {
        $filter = [
            ['id', '!=', $ship->id], // exclude own ship
            ['row', '=', $ship->row],
            ['col', '=', $ship->col],
        ];

        $neighbors = Ship::where($filter)->take(30)->get();
        return $neighbors;
    }

    protected function findItemsFloatingInSpace($ship)
    {
        $location = [
            ['row', '=', $ship->row],
            ['col', '=', $ship->col],
        ];

        $items = Item::where($location)->whereNull('ship_id')->take(30)->get();
        return $items;
    }

    /**
     * Dispose an item to outer space or near by ships if they are in the
     * same quadrant.
     *
     * @return \Illuminate\Http\Response
     */
    public function dispose(Item $item, User $user, $token)
    {
        $userShip = $user->ship;
        $neighbors = $this->findNeighborShips($userShip);

        // Position item in space before disposal
        $item->row = $userShip->row;
        $item->col = $userShip->col;

        if(count($neighbors) == 0) {
            // No neighbors (all alone indeed). As a consequence,
            // we dispose the item to outer space.
            $item->ship_id = null;
        } else {
            $anotherShip = $neighbors->random();
            $item->ship()->associate($anotherShip);
        }

        $item->save();

        return [
            'action' => 'dispose',
            'item' => $item,
            'was_collected' => $item->ship_id != null
        ];
    }

    /**
     * Collect items that are floating around in space in the same
     * quadrant that the user's ship.
     *
     * @return \Illuminate\Http\Response
     */
    public function collect(User $user, $token)
    {
        $ship = $user->ship;
        $chanceCollectNewItem = config('game.item_chance_collect_new', 10);
        $existingItemDescriptions = config('game.item_descriptions');
        $collectedItem = null;
        $floatingItems = $this->findItemsFloatingInSpace($ship);

        // There is a chance of collecting something brand new when you try
        // to collect in the quadrant
        if(rand(0, 99) <= $chanceCollectNewItem) {
            $randomDescription = Arr::random($existingItemDescriptions, 1)[0];
            $item = Item::create([
                'ship_id' => null,
                'seed' => rand(0, 1000),
                'description' => $randomDescription,
                'row' => $ship->row,
                'col' => $ship->col
            ]);
            $floatingItems[] = $item;
        }

        if(count($floatingItems) > 0) {
            $collectedItem = $floatingItems->random();
            $collectedItem->ship()->associate($ship);
            $collectedItem->save();
        }

        return [
            'action' => 'collect',
            'item' => $collectedItem
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

        $messages = Message::where($filter)->orderBy('created_at', 'asc')->take($maxReceive)->get();
        $items = Item::where('ship_id', $ship->id)->take(30)->get();
        $neighbors = $this->findNeighborShips($ship);

        return [
            'action' => 'sync',
            'user' => $user,
            'messages' => $messages,
            'items' => $items,
            'neighbors' => $neighbors
        ];
    }
}