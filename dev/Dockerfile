FROM catchdigital/php:7.3.6-fpm
MAINTAINER Alberto Contreras <a.contreras@catchdigital.com>

# Install xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug
