#!/bin/bash

# Install Memcached
apt-get install libmemcached-dev -y
pecl install memcached
docker-php-ext-enable memcached