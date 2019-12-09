# Dockerized PHP Website

The intent of the project is to have a fully-tested dockerized PHP website.

## What works

- Website with Laravel, in its own docker
- PHP in his own docker with php fpm
- PHP packages with Composer
- PostgresSQL server
- PGAdmin
- Dusk/Selenium
- Travis
- XDEBUG

## Todo

- Fix permission settings (each container is root)
- PHP Linter
- Switch website/data/.env given prod or testing

## Entrypoints

- `make serve` to build and serve
- `make test` to test (assumes things are running already)

## Remarks

- Host should run VSCode (XDEBUG config is given), have PHP set for linting

- Laravel uses `artisan` to build things. This should be called inside the docker

- Website runs on port `8080`
- PGAgmin runs on port `8081`
- PHP-Fpm runs on port `9000`
- XDebug should run on `9001` on host (to be run in VSCode, and *started* before loading the page)

- `website/data/storage` should allow "others" to write

- `php artisan key:generate` regenerates secret keys for app-level crypto
- `php artisan config:cache` flushes and rebuilds the config cache

// Magic php cache rebuid thing
composer dump-autoload

// Create a model with migration


// Rebuild db
php artisan migrate:refresh (eventuellement --seed)

// Create a seed
php artisan make:seeder SectionsTableSeeder


// Create a test in the Feature directory...
php artisan make:test UserTest

// Create a test in the Unit directory...
php artisan make:test UserTest --unit

## To credit:

https://medium.com/@jasonterando/debugging-with-visual-studio-code-xdebug-and-docker-on-windows-b63a10b0dec

https://www.toptal.com/laravel/restful-laravel-api-tutorial

https://laravel-news.com/404-responses-laravel-api

https://medium.com/@shrikeh/setting-up-nginx-and-php-fpm-in-docker-with-unix-sockets-6fdfbdc19f91

>> https://jtreminio.com/blog/running-docker-containers-as-current-host-user/

