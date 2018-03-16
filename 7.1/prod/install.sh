#!/bin/bash

# Install Memcached
pecl install memcached && \
    docker-php-ext-enable memcached