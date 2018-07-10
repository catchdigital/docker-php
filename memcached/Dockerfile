FROM catchdigital/php:7.2.7-fpm
MAINTAINER Alberto Contreras <a.contreras@catchdigital.com>

## Install necessary libraries
RUN apt-get update && apt-get install libmemcached-dev \
    && pecl install memcached \
    && docker-php-ext-enable memcached \
    && rm -rf /var/lib/apt/lists/*
