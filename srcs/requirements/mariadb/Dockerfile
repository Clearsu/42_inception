FROM debian:buster

RUN apt-get update -y && \
apt-get upgrade -y && \
apt-get install -y mariadb-server procps

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 3306

ENTRYPOINT ["/init.sh"]
