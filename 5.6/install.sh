#!/bin/bash

apt-get -y install libz-dev libmemcached-dev libmemcached11 libmemcachedutil2 build-essential \
    && pecl install memcached-2.2.0 \
    && echo extension=memcached.so >> /usr/local/etc/php/conf.d/memcached.ini