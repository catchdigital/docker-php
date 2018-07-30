FROM catchdigital/php:7.2.8-fpm
MAINTAINER Alberto Contreras <a.contreras@catchdigital.com>

## Set variables
ENV NR_INSTALL_SILENT 1

## Install wget
RUN apt-get update \
    && apt-get install wget -y

RUN wget -O - https://download.newrelic.com/548C16BF.gpg | apt-key add -
RUN sh -c 'echo "deb http://apt.newrelic.com/debian/ newrelic non-free" \
> /etc/apt/sources.list.d/newrelic.list'
RUN apt-get update
RUN apt-get install newrelic-php5 -y \
    && rm -rf /var/lib/apt/lists/*

RUN newrelic-install install
