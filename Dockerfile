ARG WORDPRESS_IMAGE

FROM $WORDPRESS_IMAGE

ARG PHP_XDEBUG_BRANCH

RUN apt-get update

RUN apt-get install -y --no-install-recommends ssl-cert
RUN a2enmod ssl && a2ensite default-ssl

RUN apt-get -y install git
RUN cd /tmp && \
    git clone https://github.com/xdebug/xdebug.git && \
    cd xdebug && \
    git checkout $PHP_XDEBUG_BRANCH && \
    phpize && \
    ./configure --enable-xdebug && \
    make && \
    make install && \
    rm -rf /tmp/xdebug
RUN docker-php-ext-enable xdebug

RUN rm -r /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

RUN chown -R www:www /var/www/html