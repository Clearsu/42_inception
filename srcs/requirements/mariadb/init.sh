#!/bin/bash

if [ ! -e "/var/lib/mysql/.init_complete" ]; then
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
  
  gosu mysql /usr/sbin/mysqld --skip-networking &

  for i in {30..0}; do
      if echo 'SELECT 1' | mysql &> /dev/null; then
          break
      fi
      sleep 1
  done

  if [ "$i" -eq 0 ]; then
      echo >&2 'MariaDB 초기화 실패'
      exit 1
  fi

  mysql -u root -e "CREATE DATABASE IF NOT EXISTS $WORDPRESS_DB;"
  mysql -u root -e "CREATE USER '$WORDPRESS_DB_USER'@'%' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';"
  mysql -u root -e "GRANT ALL ON $WORDPRESS_DB.* TO '$WORDPRESS_DB_USER'@'%';"
  mysql -u root -e "FLUSH PRIVILEGES;"
  mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD');"

  mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

  touch /var/lib/mysql/.init_complete
fi

exec gosu mysql /usr/sbin/mysqld
