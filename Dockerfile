FROM php:5-apache

MAINTAINER wil.reichert@gmail.com

ENV TIMEZONE Asia/Seoul

RUN apt-get update && \
    apt-get install -y zlib1g-dev libfreetype6-dev libjpeg62-turbo-dev \
      libmcrypt-dev libmemcached-dev libpng12-dev python-pip git \
      unrar-free par2 p7zip-full libav-tools lame mediainfo mysql-client \
      tmux screen htop

RUN docker-php-ext-install -j$(nproc) \
      mcrypt \
      exif \
      opcache \
      pcntl \
      pdo_mysql \
      sockets && \
    docker-php-ext-configure gd \
      --with-freetype-dir=/usr/include \
      --with-jpeg-dir=/usr/include \
      --with-png-dir=/usr/include && \
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-configure pdo_mysql \
      --with-zlib-dir=/usr/include && \
    docker-php-ext-install -j$(nproc) pdo_mysql && \
    pecl install memcache && \
    docker-php-ext-enable memcache && \
    echo "register_globals = Off" > /usr/local/etc/php/conf.d/nzedb.ini && \
    echo "max_execution_time = 120" >> /usr/local/etc/php/conf.d/nzedb.ini && \
    echo "memory_limit = 1024M" >> /usr/local/etc/php/conf.d/nzedb.ini && \
    echo "date.timezone = $TIMEZONE" >> /usr/local/etc/php/conf.d/nzedb.ini && \
    pip install cymysql

COPY nzedb.conf /etc/apache2/sites-available/nzedb.conf

RUN a2dissite 000-default && \
	  a2ensite nzedb && \
	  a2enmod rewrite && \
    cd /var/www && \
    curl https://raw.githubusercontent.com/composer/getcomposer.org/1b137f8bf6db3e79a38a5bc45324414a6b1f9df2/web/installer | php -- && \
    php composer.phar create-project --no-dev --keep-vcs nzedb/nzedb && \
    echo "define('MEMCACHE_ENABLED', true);" >> /var/www/nzedb/nzedb/config/config.php && \
    echo "define('MEMCACHE_HOST', 'memcached');" >> /var/www/nzedb/nzedb/config/config.php && \
    echo "define('MEMCACHE_PORT', '11211');" >> /var/www/nzedb/nzedb/config/config.php && \
    echo "define('MEMCACHE_EXPIRY', '900');" >> /var/www/nzedb/nzedb/config/config.php && \
    echo "define('MEMCACHE_COMPRESSION', true);" >> /var/www/nzedb/nzedb/config/config.php && \
    chmod 777 /var/www && \
    chmod 777 /var/www/nzedb/nzedb/config && \
    chmod -R 777 /var/www/nzedb/resources/covers && \
    chmod -R 777 /var/www/nzedb/resources/nzb && \
    chmod 777 /var/www/nzedb/resources/smarty/templates_c && \
    mkdir -p /var/www/nzedb/resources/tmp/unrar && \
    chmod -R 777 /var/www/nzedb/resources/tmp/unrar && \
    chmod 777 /var/www/nzedb/www && \
    chmod -R 777 /var/www/nzedb/www/covers && \
    chmod 777 /var/www/nzedb/www/install && \
    curl -o /etc/ssl/certs/cacert.pem https://curl.haxx.se/ca/cacert.pem && \
    mkdir /var/lib/php5 && \
    chmod o+r /var/lib/php5


RUN cd /usr/local/src && \
    curl -L -o yydecode-0.2.10.tar.gz http://downloads.sourceforge.net/project/yydecode/yydecode/0.2.10/yydecode-0.2.10.tar.gz && \
    tar -xvf yydecode-0.2.10.tar.gz && \
    cd yydecode-0.2.10 && \
    ./configure && \
    make && \
    make install && \
    cd && \
    rm -rf /usr/local/src/*


EXPOSE 80

VOLUME /var/www/nzedb

WORKDIR /var/www/nzedb
