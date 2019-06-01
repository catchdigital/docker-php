# docker-php

Basic PHP image with extra setting ready to use.

## Version

* `7.3.6-fpm`: PHP 7.3.6 with the necessary tools to run a site. (Latest)
* `7.3.6-fpm-dev`: Extensions of 7.3.6-fpm with xdebug for development
* `7.3.6-fpm-newrelic`: Extensions of 7.3.6-fpm with newrelic php extension

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
