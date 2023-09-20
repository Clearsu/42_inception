FROM debian:buster

RUN apt-get update -y && \
apt-get upgrade -y && \
apt-get install -y mariadb-server

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY init.sql /
RUN chmod +x /init.sql

RUN service mysql start && mysql < /init.sql && rm -f /init.sql

EXPOSE 3306

CMD ["/usr/sbin/mysqld", "--bind-address=0.0.0.0"]
