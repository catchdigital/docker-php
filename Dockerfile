FROM php:7.3.6-fpm
MAINTAINER Alberto Contreras <a.contreras@catchdigital.com>

# install default PHP extensions
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libzip-dev libpq-dev libldap2-dev mysql-client rsyslog imagemagick \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install gd mbstring opcache pdo pdo_mysql pdo_pgsql zip ldap

# Install soap client.
RUN apt-get install libxml2-dev -y \
    && docker-php-ext-install soap

## Install necessary libraries
RUN apt-get install libmemcached-dev -y \
    && pecl install memcached \
    && docker-php-ext-enable memcached

# Install imagick
RUN apt-get install -y libmagickwand-6.q16-dev --no-install-recommends \
  && ln -s /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16/MagickWand-config /usr/bin \
  && pecl install imagick \
  && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=60'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

# Create CMd start file
RUN { \
        echo '#!/bin/bash'; \
        echo 'rsyslogd'; \
        echo 'php-fpm'; \
    } > /php-fpm.sh
RUN chmod +x /php-fpm.sh

# Clean up
RUN rm -rf /var/lib/apt/lists/*

# Set up working directory
WORKDIR /var/www/html

RUN usermod -u 1000 www-data
RUN usermod -a -G users www-data

RUN chown -R www-data:www-data /var/www

# Start services
CMD ["/php-fpm.sh"]
