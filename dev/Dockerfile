FROM catchdigital/php:7.3.15-fpm
MAINTAINER Alberto Contreras <a.contreras@catchdigital.com>

# Install xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug
