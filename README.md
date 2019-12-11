# PHP+nginx+PostgreSQL+pgAdmin on Docker in 2019 

This code is a template for a PHP website ([Laravel](https://laravel.com/) served via nginx and [php-fpm](https://php-fpm.org/)) along with its database ([PostgreSQL](https://www.postgresql.org)+[pgAdmin](https://www.pgadmin.org/)).

It *just works*: [![Build Status](https://travis-ci.com/lbarman/laravel-test.svg?branch=master)](https://travis-ci.com/lbarman/laravel-test). Clone and get started.

**Why?** Because this has been surprisingly time-consuming to setup (see the "pain points" below), and it really shouldn't be.

## What's in the box

- Minimal website with Laravel, served via nginx and php-fpm, all wired up through docker-compose
- PostgreSQL+pgAdmin
- Source code + DB files mapped to host through Docker volumes
- Simplified dev cycle through `Makefile` commands (`make serve`, `serve-dev`, `test-unit`, `test-integration`, etc)
- Composer to manage PHP libraries
- **Working CI setup** with Travis for unit tests, plus...
- **Dusk/Selenium** for integration-tests, which runs on Travis **and** uploads failing screenshots to [imgur](https://imgur.com/)
- Working XDEBUG setup for VS Studio Code/PHPStorm (so you can debug with breakpoints)

## How to use

- Clone this repo
- `make serve` to build and serve
- `make composer-update` on the first run
- `make test` to run unit and integration tests

## Pain points solved

- No turnkey setup available: either [partial](https://github.com/thayronarrais/docker-laravel-postgres-nginx)* [solutions](https://github.com/dimadeush/docker-nginx-php-laravel)**, or [many](https://dev.to/baliachbryan/deploying-your-laravel-app-on-docker-with-nginx-and-mysql-56ni) [blog](https://www.digitalocean.com/community/tutorials/how-to-set-up-laravel-nginx-and-mysql-with-docker-compose) [posts](https://www.howtoforge.com/tutorial/dockerizing-laravel-with-nginx-mysql-and-docker-compose/) which I had to painfully combine to get this setup
- PostgreSQL creates files as **root**, which conflicts with docker build (solution: appropriate [`.dockerbuild`](.dockerbuild)). Similar problem for `artisan` (solution: appropriate [alias](./artisan))
- Running `composer install` in the `Dockerfile` was shadowed by the volume mapping the source to the host (solution: separate command in `Makefile`, required once only)
- Simultaneously running `make serve` and `make test` on Travis (solution: script to [busy-wait on container](./utils/wait-for-docker-container.sh))
- Getting Dusk/Selenium's output on failures on Travis (solution: [a script](./utils/dusk-failure-report.sh) to copy to stdout and upload screenshots to imgur)
- Getting the PHP container to connect to XDEBUG on host (solution: [a hack](./utils/fix-host-docker.sh) to fix `host.docker.internal` on Linux)

*(lacks CI) **(lacks DB)

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


