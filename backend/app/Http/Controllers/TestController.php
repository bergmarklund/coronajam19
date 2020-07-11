<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

use App\Item;
use App\Message;
use App\Ship;
use App\User;

class TestController extends Controller
{
    public function __construct()
    {
    }

    /**
     *
     */
    public function index()
    {
        return [
            'action' => 'test',
            'test' => 'hi!'
        ];
    }
}