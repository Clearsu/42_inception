FROM debian:buster

RUN apt-get update -y \
&& apt-get upgrade -y \
&& apt-get -y install \
php7.3 \
php-fpm \
php-cli \
php-mysql \
php-mbstring \
php-xml \
mariadb-client \
wget \
curl \
sendmail

RUN mkdir /run/php \
&& wget https://wordpress.org/latest.tar.gz \
&& tar -xvf /latest.tar.gz \
&& sleep 5 \
&& mkdir -p /var/www/html/ \
&& cp -rL /wordpress/* /var/www/html/ \
&& chown -R www-data:www-data /var/www/html \
&& rm -r /wordpress latest.tar.gz

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& php wp-cli.phar --info \
&& chmod +x wp-cli.phar \
&& mv wp-cli.phar /usr/bin/wp \
&& wp --info

# COPY wp-config.php /var/www/html/wp-config.php
COPY www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 9000

CMD ["/bin/bash", "/init.sh"]
