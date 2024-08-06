FROM catchdigital/php:8.3.10-fpm

## Install required packages.
RUN apt-get update && apt-get install -y git golang

RUN git clone https://github.com/newrelic/newrelic-php-agent.git /var/www/newrelic-php-agent

WORKDIR /var/www/newrelic-php-agent

# Manually install newrelic agent.
RUN make all && \
    make agent-install && \
    mkdir /var/log/newrelic && \
    chmod 777 /var/log/newrelic && \
    mkdir -p /etc/php.d && \
    cp agent/scripts/newrelic.ini.template /etc/php.d/newrelic.ini && \
    cp bin/daemon /usr/bin/newrelic-daemon

RUN apt-get remove -y git golang

# Clean up.
RUN apt-get -y autoremove && apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/www/newrelic-php-agent
