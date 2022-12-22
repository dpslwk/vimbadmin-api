<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Laminas\Config\Reader\Ini;

class VbaConfigServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        // load up the vba config ini
        $vbaArray = (new Ini())->fromFile(env('VBA_CONFIG_FILE'))['user'];
        $this->app['config']->set('vba', $vbaArray);
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
