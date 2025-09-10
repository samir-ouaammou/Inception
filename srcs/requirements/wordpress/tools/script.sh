#!/bin/bash

sleep 5

if [ ! -f /usr/local/bin/wp ]; then
    wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar 
    mv wp-cli.phar /usr/local/bin/wp
fi

mkdir -p /var/www/html
mkdir -p /run/php
cd /var/www/html

if [ ! -f index.php ]; then
    wp core download --allow-root
fi

if [ ! -f wp-config.php ]; then
    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="mariadb:3306" \
        --allow-root

    echo "if (!isset(\$_SERVER['HTTP_HOST'])) { \$_SERVER['HTTP_HOST'] = 'localhost'; }" >> wp-config.php
fi

if ! wp core is-installed --allow-root; then
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="INCEPTION" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root
fi

if ! wp user get "$WP_USER" --allow-root >/dev/null 2>&1; then
    wp user create \
        "$WP_USER" "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PASSWORD" \
        --allow-root
fi

sed -i 's#listen = /run/php/php8.4-fpm.sock#listen = 0.0.0.0:9000#' /etc/php/8.4/fpm/pool.d/www.conf

chown -R www-data:www-data /var/www/html
chmod -R 777 /var/www/html
chown -R www-data:www-data /var/www/html/wp-content
chmod -R 777 /var/www/html/wp-content

wp plugin install redis-cache --activate --allow-root

if wp redis status --allow-root | grep -q "disabled"; then
    wp redis enable --host=redis --port=6379 --allow-root
fi

if ! grep -q "WP_REDIS_HOST" wp-config.php; then
    echo "define('WP_REDIS_HOST', 'redis');" >> wp-config.php
    echo "define('WP_REDIS_PORT', 6379);" >> wp-config.php
fi

echo "🚀 Starting php-fpm..."
exec /usr/sbin/php-fpm8.4 -F
