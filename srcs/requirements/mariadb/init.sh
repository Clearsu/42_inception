#!/bin/bash

if [ ! -e "/var/lib/mysql/.init_complete" ]; then
  service mysql start

  mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DB;"
  mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');"
  mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
  mysql -e "GRANT ALL ON $MYSQL_DB.* TO '$MYSQL_USER'@'%';"
  mysql -e "FLUSH PRIVILEGES;"

  touch /var/lib/mysql/.init_complete
fi

exec /usr/sbin/mysqld
