#!/bin/bash
set -e

mkdir -p /etc/nginx/ssl

openssl req -x509 -nodes \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=MA/ST=benguerir/L=UM6P/O=1337/CN=${WORDPRESS_DOMAIN}"

nginx -g "daemon off;"
