#!/bin/bash

set -e

sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/8.4/fpm/pool.d/www.conf

mkdir -p /var/www/html

if [ ! -f /var/www/html/index.php ]; then
  wp core download --allow-root --path=/var/www/html
fi

cp /wp-config.php /var/www/html/wp-config.php

echo "Waiting for MariaDB to be ready..."
until mysqladmin ping -h "$WORDPRESS_DB_HOST" --silent; do
    sleep 1
done
echo "MariaDB is up, continuing..."

wp config set DB_NAME ${WORDPRESS_DB_NAME} --allow-root --path=/var/www/html
wp config set DB_USER ${WORDPRESS_DB_USER} --allow-root --path=/var/www/html
wp config set DB_PASSWORD ${WORDPRESS_DB_PASSWORD} --allow-root --path=/var/www/html
wp config set DB_HOST ${WORDPRESS_DB_HOST} --allow-root --path=/var/www/html

wp core install \
  --url="https://${WORDPRESS_DOMAIN}" \
  --title="My Website" \
  --admin_user="${WORDPRESS_ADMIN_USER}" \
  --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
  --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
  --allow-root \
  --path=/var/www/html

wp user create "${WORDPRESS_USER}" "${WORDPRESS_USER_EMAIL}" \
  --user_pass="${WORDPRESS_USER_PASSWORD}" \
  --role=subscriber \
  --allow-root \
  --path=/var/www/html

chmod -R 777 /var/www/html

php-fpm8.4 -F
