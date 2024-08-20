## How to execute
1. You need a `.env` file in `srcs` directory. The environment variables will be passed into docker images while building.
```
#.env
MYSQL_DB=testdb
MYSQL_USER=mysqladmin
MYSQL_PASSWORD=1234
MYSQL_ROOT_PASSWORD=helloworld
WP_TITLE=example
WP_ADMIN_USER=wpadmin
WP_ADMIN_PASSWORD=1q2w3e4r
WP_ADMIN_EMAIL=helloworld@gmail.com
WP_NORMAL_USER=user1
WP_NORMAL_USER_PASSWORD=guessit
```
2. `make all` and it will add `${your username}.42.fr` to your `/etc/hosts` file (which will require root previlege), create containers and run them.
3. Now you can access your wordpress webpage with 'https://${username}.42.fr'. It is normal to see the warning message since `SSL certificate` is self-signed.
