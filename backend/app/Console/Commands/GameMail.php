<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

use App\Message;
use Illuminate\Support\Carbon;

class GameMail extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'game:mail';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Deletes old messages sent by players.';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $messageMaxTTLMin = config('game.message_max_ttl_min', 1);
        $nowMinusTTL = Carbon::now()->subMinutes($messageMaxTTLMin);

        Message::where('created_at', '<', $nowMinusTTL)->delete();

        return 0;
    }
}
