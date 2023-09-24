#!/bin/bash

if [ ! -e "/var/lib/mysql/.init_complete" ]; then
  service mysql start
  sleep 10

  mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DB;"
  mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');"
  mysql -e "CREATE USER '$MYSQL_USER'@'wordpress' IDENTIFIED BY '$MYSQL_PASSWORD';"
  mysql -e "GRANT ALL ON $MYSQL_DB.* TO '$MYSQL_USER'@'wordpress';"
  mysql -e "FLUSH PRIVILEGES;"

  touch /var/lib/mysql/.init_complete
fi

exec gosu mysql /usr/sbin/mysqld --no-daemonize
