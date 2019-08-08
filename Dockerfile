FROM php:7.2-fpm-alpine

# Production settings to be checked

# Use the default production configuration
# RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
# Override with custom opcache settings
# COPY config/opcache.ini $PHP_INI_DIR/conf.d/

RUN apk update && apk add build-base

RUN apk add postgresql postgresql-dev \
  && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
  && docker-php-ext-install pdo pdo_pgsql pgsql

RUN apk add zlib-dev git zip \
  && docker-php-ext-install zip

RUN curl -sS https://getcomposer.org/installer | php \
        && mv composer.phar /usr/local/bin/ \
        && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer

COPY website /website
WORKDIR /website

RUN composer install --prefer-source --no-interaction

ENV PATH="~/.composer/vendor/bin:./vendor/bin:${PATH}"
