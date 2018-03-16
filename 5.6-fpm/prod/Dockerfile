FROM php:5.6-fpm
MAINTAINER Liam Hiscock

# Install the PHP extensions we need
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libpq-dev libldap2-dev mysql-client\
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install gd mbstring opcache pdo pdo_mysql pdo_pgsql zip ldap

# Install version specific plugins.
ADD install.sh install.sh
RUN chmod +x install.sh && sh ./install.sh && rm install.sh

# Project cleanup.
RUN rm -rf /var/lib/apt/lists/*

# Set recommended PHP.ini settings
# See https://secure.php.net/manual/en/opcache.installation.php
RUN { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=60'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

WORKDIR /var/www/html

RUN usermod -u 1000 www-data
RUN usermod -a -G users www-data

RUN chown -R www-data:www-data /var/www
