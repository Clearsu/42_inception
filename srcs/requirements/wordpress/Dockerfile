FROM debian:buster

RUN apt-get update -y && \
apt-get upgrade -y && \
apt-get -y install \
php7.3 \
php-fpm \
php-cli \
wget \
curl \
php-mysql \
php-mbstring \
php-xml
# sendmail

RUN mkdir /run/php

RUN wget https://wordpress.org/latest.tar.gz && \
tar -xvf latest.tar.gz && \ 
mkdir -p /var/www/html/ && \
mv /wordpress/* /var/www/html/ && \
chown -R www-data:www-data /var/www/html && \
rm -r /wordpress latest.tar.gz

COPY wp-config.php /var/www/html/wp-config.php
COPY www.conf /etc/php/7.3/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "-F"]
