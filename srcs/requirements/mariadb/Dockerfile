FROM debian:buster

RUN apt-get update -y && \
apt-get upgrade -y && \
apt-get install -y mariadb-server

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysqld && \
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

EXPOSE 3306

COPY init.sh /init.sh
RUN chmod +x /init.sh

ENTRYPOINT ["/bin/bash", "/init.sh"]

CMD ["/usr/sbin/mysqld"]
