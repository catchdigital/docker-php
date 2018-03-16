#!/bin/bash

# Install Memcached
apt-get install libmemcached-dev -y
pecl install memcached
docker-php-ext-enable memcached

if [ ! -z $1 ] && [ $1="dev" ]; then
   pecl install xdebug
   docker-php-ext-enable xdebug
fi