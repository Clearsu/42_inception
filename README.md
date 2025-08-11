# Inception
<img width="910" height="739" alt="image" src="https://github.com/user-attachments/assets/232f8787-653b-4cd8-90b7-7f6e58eaa8c5" />

This project sets up a WordPress website powered by MariaDB and served via Nginx over HTTPS, using Docker Compose with custom-built images.

## Diagram
<img width="612" height="702" alt="image" src="https://github.com/user-attachments/assets/4f616342-c5bf-4dff-ac6a-0d3c89efd77f" />


## How to execute
1. Start Docker Desktop (or Docker Daemon).
2. Create `.env` in `/srcs`.
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
DOMAIN_NAME=[YOUR HOSTNAME].42.fr
```
3. Run
```
make all
```
- Adds [YOUR HOSTNAME].42.fr to /etc/hosts
- Builds and starts containers
5. Access
```
https://[YOUR HOSTNAME].42.fr
```
SSL warning is normal – self-signed certificate
