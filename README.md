# docker-php

Basic PHP image with extra setting ready to use.

## Version

* `8.2.19-fpm`: PHP 8.1.3 with the necessary tools to run a site. (Latest)
* `8.2.19-fpm-dev`: Extensions of 8.1.3-fpm with xdebug for development
* `8.2.19-fpm-newrelic`: Extensions of 8.1.3-fpm with newrelic php extension

## Modules

Beside the necessary libraries, it contains also:

* mysql-client
* rsyslog
* imagemagick

## PHP extensions

* memcached
* soap
* opcache
* gd
* mbstring
* zip
* ldap
* xdebug (only dev version)
* newrelic (only newrelic version)
