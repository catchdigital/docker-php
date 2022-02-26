FROM catchdigital/php:8.0.16-fpm
MAINTAINER Alberto Contreras <a.contreras@catchdigital.com>

# Install xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug
