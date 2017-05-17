<?php

namespace App\Providers;

use Zend\Config\Reader\Ini;
use Illuminate\Support\ServiceProvider;

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
        $vbaArray = (new Ini)->fromFile(env('VBA_CONFIG_FILE'))['user'];
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
