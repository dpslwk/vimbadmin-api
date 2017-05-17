<?php

namespace App\Providers;

use App\Exceptions\ForbidenException;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        app('validator')->extend('null', function ($attribute, $value, $parameters, $validator) {
            return is_null($value);
        }, 'The :attribute must be null.');

        app('validator')->extend('client_generated_id_forbiden', function ($attribute, $value, $parameters, $validator) {
            if (is_null($value)) {
                return true;
            }
            throw new ForbidenException('Client generated IDs are forbiden.');
        }, 'Client generated IDs are forbiden.');
    }

    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }
}
