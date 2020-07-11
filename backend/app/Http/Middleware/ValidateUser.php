<?php

namespace App\Http\Middleware;

use Closure;

class ValidateUser
{
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
        $user = \App\User::where('token', $token)->first();

        if($user == null) {
            return response()->json(['message' => 'User not found with provided token: ' . $token], 401);
        }

        return $next($request);
    }
}