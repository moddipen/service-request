<?php

namespace App\Providers;

use Illuminate\Support\Facades\Route;
use Illuminate\Foundation\Support\Providers\RouteServiceProvider as ServiceProvider;

class RouteServiceProvider extends ServiceProvider
{
    /**
     * This namespace is applied to your controller routes.
     *
     * In addition, it is set as the URL generator's root namespace.
     *
     * @var string
     */
    protected $namespace = 'App\Http\Controllers\Api';

    /**
     * Define your route model bindings, pattern filters, etc.
     *
     * @return void
     */
    public function boot()
    {
        //

        parent::boot();
    }

    /**
     * Define the routes for the application.
     *
     * @return void
     */
    public function map()
    {
        $this->mapApiRoutes();

        $this->mapWebRoutes();

        $this->mapAdminRoutes();

        $this->mapCompanyRoutes();

        $this->mapContractorRoutes();
    }

    /**
     * Define the "web" routes for the application.
     *
     * These routes all receive session state, CSRF protection, etc.
     *
     * @return void
     */
    protected function mapWebRoutes()
    {
        Route::middleware('web')
             ->namespace($this->namespace)
             ->group(base_path('routes/web.php'));
    }

    /**
     * Define the "api" routes for the application.
     *
     * These routes are typically stateless.
     *
     * @return void
     */
    protected function mapApiRoutes()
    {
        Route::prefix('v1/api')
             ->middleware('api')
             ->namespace($this->namespace)
             ->group(base_path('routes/api.php'));
    }

    /**
     * Define the "super admin api" routes for the application.
     *
     * These routes are typically stateless.
     *
     * @return void
     */
    protected function mapAdminRoutes()
    {
        Route::prefix('v1/api/admin')
            ->middleware('auth:api')
            ->namespace($this->namespace.'\Admin')
            ->group(base_path('routes/admin.php'));
    }

    /**
     * Define the "company users api" routes for the application.
     *
     * These routes are typically stateless.
     *
     * @return void
     */
    protected function mapCompanyRoutes()
    {
        Route::prefix('v1/api/company')
            ->middleware(['api', 'multiauth:company'])
            ->namespace($this->namespace.'\Company')
            ->group(base_path('routes/company.php'));
    }

    /**
     * Define the "contractor users api" routes for the application.
     *
     * These routes are typically stateless.
     *
     * @return void
     */
    protected function mapContractorRoutes()
    {
        Route::prefix('v1/api/contractor')
            ->middleware(['api', 'multiauth:contractor'])
            ->namespace($this->namespace.'\Contractor')
            ->group(base_path('routes/contractor.php'));
    }
}
