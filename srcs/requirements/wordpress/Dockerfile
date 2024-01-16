FROM debian:bullseye

RUN apt-get update -y \
&& apt-get upgrade -y \
&& apt-get -y install \
php7.4 \
php-fpm \
php-cli \
php-mysql \
php-mbstring \
php-xml \
mariadb-client \
curl \
sendmail

RUN mkdir /run/php \
&& mkdir -p /var/www/html/ \
&& chown -R www-data:www-data /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& chmod +x wp-cli.phar \
&& mv wp-cli.phar /usr/local/bin/wp

COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 9000

WORKDIR /var/www/html

ENTRYPOINT ["/bin/bash", "/init.sh"]

CMD ["/usr/sbin/php-fpm7.4", "-F"]
