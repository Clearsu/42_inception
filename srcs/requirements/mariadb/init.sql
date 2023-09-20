CREATE DATABASE IF NOT EXISTS wordpress_db;
CREATE USER 'jincpark'@'%' IDENTIFIED BY 'password';
GRANT ALL ON wordpress_db.* TO 'jincpark'@'%';
FLUSH PRIVILEGES;