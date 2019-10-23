# Dockerized PHP Website

The intent of the project is to have a fully-tested dockerized PHP website.

## What works

- Website with Laravel, in its own docker
- PHP in his own docker with php fpm
- PHP packages with Composer
- PostgresSQL server
- PGAdmin

## Todo

- Selenium
- Travis
- Switch website/data/.env given prod or testing

## Entrypoints

- `make serve` to build and serve
- `make test` to test (assumes things are running already)

## Remarks

- Laravel uses `artisan` to build things. This should be called inside the docker

- Website runs on port `8080`
- PGAgmin runs on port `8081`
- PHP-Fpm runs on port `9000`