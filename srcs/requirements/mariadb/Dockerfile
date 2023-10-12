FROM debian:buster

RUN apt-get update -y && \
apt-get upgrade -y && \
apt-get install -y mariadb-server procps gosu && \
rm -rf /var/lib/apt/lists/*

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysqld && \
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

COPY init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 3306

CMD ["/init.sh"]


# ENTRYPOINT ["/bin/bash", "-c", "tail -f /dev/null"]
