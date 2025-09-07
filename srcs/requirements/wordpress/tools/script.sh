#!/bin/bash
sleep 4

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar 

mv wp-cli.phar /usr/local/bin/wp

mkdir -p /var/www/html

mkdir -p /run/php

cd /var/www/html

wp core download --allow-root

mv wp-config-sample.php wp-config.php

wp config set --allow-root DB_NAME $MYSQL_DATABASE --path='/var/www/html'
wp config set --allow-root DB_USER $MYSQL_USER --path='/var/www/html'
wp config set --allow-root DB_PASSWORD $MYSQL_PASSWORD --path='/var/www/html' 
wp config set --allow-root DB_HOST 'mariadb:3306' --path='/var/www/html'

wp core install  \
	--url=$DOMAIN_NAME --title=INCEPTION \
	--admin_user=$WP_ADMIN_USER \
	--admin_password=$WP_ADMIN_PASSWORD \
	--admin_email=$WP_ADMIN_EMAIL \
	--allow-root --path='/var/www/html'


wp user create  \
	$WP_USER $WP_USER_EMAIL --role=author \
	--user_pass=$WP_USER_PASSWORD --allow-root --path='/var/www/html'

sed -i 's#listen = /run/php/php7.4-fpm.sock#listen = 0.0.0.0:9000#' /etc/php/7.4/fpm/pool.d/www.conf

/usr/sbin/php-fpm7.4 -F
