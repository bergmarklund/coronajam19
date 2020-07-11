<?php

namespace App\Http\Middleware;

use Closure;

class ValidateUser
{
    protected $user = null;

    /**
     * Check if the incoming request has a valid user token.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        $token = $request->route('token');
        $this->user = \App\User::where('token', $token)->first();

        if($this->user == null) {
            return response()->json(['message' => 'User not found with provided token: ' . $token], 401);
        }

        return $next($request);
    }

    public function user()
    {
        return $this->user;
    }
}