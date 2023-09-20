FROM debian:buster

RUN apt-get update -y && \
apt-get upgrade -y && \
apt-get -y install nginx openssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/server_pkey.pem -out /etc/ssl/certs/server.crt -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=42Seoul/CN=jincpark.42.fr"

COPY default /etc/nginx/sites-available/default

CMD ["nginx", "-g", "daemon off;"]