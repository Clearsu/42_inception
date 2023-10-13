#!/bin/bash

if [ ! -e "/var/lib/mysql/.init_complete" ]; then
  # MariaDB 데이터 디렉토리 초기화
  mysql_install_db --user=mysql --datadir=/var/lib/mysql
  
  # 임시로 MariaDB를 백그라운드에서 시작합니다.
  gosu mysql /usr/sbin/mysqld --skip-grant-tables --skip-networking --pid-file=/var/run/mysqld/mysqld.pid &  

  
  # MariaDB가 준비될 때까지 기다리기 위한 로직
  for i in {30..0}; do
      if echo 'SELECT 1' | mysql &> /dev/null; then
          break
      fi
      sleep 1
  done
  
  if [ "$i" = 0 ]; then
      echo >&2 'MariaDB 초기화 실패'
      exit 1
  fi
  
  # root 비밀번호 변경
  mysql -e "UPDATE mysql.user SET Password=PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE User='root';"
  mysql -e "FLUSH PRIVILEGES;"

  # 백그라운드에서 실행중인 MariaDB를 종료
    kill -TERM $(cat /var/run/mysqld/mysqld.pid)
    sleep 5
  # mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

  if [ -f /var/run/mysqld/mysqld.pid ]; then
      rm -f /var/run/mysqld/mysqld.pid
  fi

  # MariaDB를 일반 모드로 다시 시작
  gosu mysql /usr/sbin/mysqld --skip-networking --pid-file=/var/run/mysqld/mysqld.pid &  

  # 다시 MariaDB가 준비될 때까지 기다립니다.
  for i in {30..0}; do
      if echo 'SELECT 1' | mysql -u root -p$MYSQL_ROOT_PASSWORD &> /dev/null; then
          break
      fi
      sleep 1
  done
  
  # 이제 일반 모드에서 권한 관련 작업을 수행합니다.
  mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DB;"
  mysql -u root -p$MYSQL_ROOT_PASSWORD -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
  mysql -u root -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL ON $MYSQL_DB.* TO '$MYSQL_USER'@'%';"
  mysql -u root -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

  # 백그라운드에서 실행중인 MariaDB를 다시 종료
    kill -TERM $(cat /var/run/mysqld/mysqld.pid)
    sleep 5
  # mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
  
  touch /var/lib/mysql/.init_complete
fi

# MariaDB 서버를 정상적으로 시작
exec gosu mysql /usr/sbin/mysqld
