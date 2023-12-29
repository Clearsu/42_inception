FROM debian:buster

RUN apt-get update -y && \
apt-get upgrade -y && \
apt-get -y install \
php7.3 \
php-fpm \
php-cli \
php-mysql \
php-mbstring \
php-xml \
wget \
curl \
sendmail

RUN mkdir /run/php
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvf /latest.tar.gz
RUN sleep 5
RUN mkdir -p /var/www/html/
RUN cp -rL /wordpress/* /var/www/html/
RUN chown -R www-data:www-data /var/www/html
# RUN rm -r /wordpress latest.tar.gz

COPY wp-config.php /var/www/html/wp-config.php
COPY www.conf /etc/php/7.3/fpm/pool.d/www.conf

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "-F"]
