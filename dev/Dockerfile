FROM catchdigital/php:8.1.5-fpm
MAINTAINER Alberto Contreras <a.contreras@catchdigital.com>

# Install xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug
