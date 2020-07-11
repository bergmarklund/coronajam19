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
        $this->middleware('validated');
    }

    /**
     *
     */
    public function index()
    {
        return ['test' => 'hi!'];
    }
}