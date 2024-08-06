FROM php:8.3.10-fpm

ARG TARGETPLATFORM

# Supported architectures.
RUN case $TARGETPLATFORM in \
  linux/amd64) LIBDIR='x86_64-linux-gnu';; \
  linux/arm64) LIBDIR='aarch64-linux-gnu';; \
  *) echo "unsupported architecture"; exit 1 ;; \
esac

# install default PHP extensions
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libonig-dev libzip-dev libpq-dev libldap2-dev libbz2-dev default-mysql-client rsyslog imagemagick libwebp-dev webp libmagickwand-dev openssh-client \
  && docker-php-ext-configure gd --with-jpeg --with-webp \
  && docker-php-ext-configure ldap --with-libdir=lib/$LIBDIR/ \
  && docker-php-ext-install gd mbstring opcache pdo pdo_mysql pdo_pgsql zip ldap bz2

# Install soap client.
RUN apt-get install libxml2-dev -y \
  && docker-php-ext-install soap

# Install BCMath
RUN docker-php-ext-install bcmath

## Install necessary libraries
RUN apt-get install libmemcached-dev -y \
  && pecl install memcached \
  && docker-php-ext-enable memcached

# Install imagick
# RUN apt-get install -y libmagickwand-6.q16-dev --no-install-recommends \
#   && ln -s /usr/lib/$LIBDIR/ImageMagick-6.8.9/bin-Q16/MagickWand-config /usr/bin \
#   && pecl install imagick \
#   && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini

# Imagick is installed from the archive because regular installation fails
# See: https://github.com/Imagick/imagick/issues/643#issuecomment-1834361716
ARG IMAGICK_VERSION=3.7.0
RUN curl -L -o /tmp/imagick.tar.gz https://github.com/Imagick/imagick/archive/refs/tags/${IMAGICK_VERSION}.tar.gz \
    && tar --strip-components=1 -xf /tmp/imagick.tar.gz \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini \
    && rm -rf /tmp/*
    # <<< End of Imagick installation

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

# Create CMD start file
RUN { \
  echo '#!/bin/bash'; \
  echo 'rsyslogd'; \
  echo 'php-fpm'; \
} > /php-fpm.sh
RUN chmod +x /php-fpm.sh

# Clean up
RUN rm -rf /var/lib/apt/lists/*

# Configure www-data user
RUN usermod -u 33 www-data \
  && usermod -a -G users www-data \
  && usermod -d /root www-data

# Set up bash
COPY ./.bashrc /root/.bashrc

# Set up working directory
WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www

# Add project composer bin to PATH
ENV PATH=$PATH:/var/www/html/vendor/bin

# Start services
CMD ["/php-fpm.sh"]
