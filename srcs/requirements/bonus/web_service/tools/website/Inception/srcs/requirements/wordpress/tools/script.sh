#!/bin/bash
# Use Bash shell to execute this script

sleep 5
# Wait 5 seconds to ensure that dependent services like MariaDB are up and running

if [ ! -f /usr/local/bin/wp ]; then
    # Check if WP-CLI (WordPress Command Line Interface) is not already installed
    wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    # Download WP-CLI from official GitHub repository quietly (-q = quiet)
    chmod +x wp-cli.phar
    # Make the downloaded WP-CLI file executable
    mv wp-cli.phar /usr/local/bin/wp
    # Move WP-CLI to /usr/local/bin to make 'wp' command globally available
fi

mkdir -p /var/www/html
# Create WordPress web root directory if it doesn't exist
mkdir -p /run/php
# Create PHP runtime directory for php-fpm if it doesn't exist
cd /var/www/html
# Move into web root directory for all subsequent WordPress commands

if [ ! -f index.php ]; then
    wp core download --allow-root
    # Download WordPress core files if index.php does not exist
    # --allow-root is required because the Docker container usually runs as root
fi

if [ ! -f wp-config.php ]; then
    # Check if wp-config.php does not exist
    wp config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="mariadb:3306" \
        --allow-root
    # Generate wp-config.php using environment variables for database credentials
    # This allows WordPress to connect to the MariaDB container

    echo "if (!isset(\$_SERVER['HTTP_HOST'])) { \$_SERVER['HTTP_HOST'] = 'localhost'; }" >> wp-config.php
    # Append PHP code to wp-config.php to ensure HTTP_HOST is defined
    # Prevents errors for some plugins that expect HTTP_HOST to exist
fi

if ! wp core is-installed --allow-root; then
    # Check if WordPress core is not installed yet
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="INCEPTION" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root
    # Install WordPress core with the admin credentials and site info
    # --skip-email disables sending the welcome email
fi

if ! wp user get "$WP_USER" --allow-root >/dev/null 2>&1; then
    # Check if a specific non-admin user exists
    wp user create \
        "$WP_USER" "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PASSWORD" \
        --allow-root
    # Create a WordPress user with the specified role and password
fi

sed -i 's#listen = /run/php/php8.4-fpm.sock#listen = 0.0.0.0:9000#' /etc/php/8.4/fpm/pool.d/www.conf
# Modify PHP-FPM configuration to listen on TCP port 9000 instead of Unix socket
# Allows Nginx (or other containers) to communicate with PHP-FPM over the network

chown -R www-data:www-data /var/www/html
# Ensure web root directory is owned by www-data (user used by PHP/Nginx)
chmod -R 777 /var/www/html
# Temporarily grant full permissions for development/testing
chown -R www-data:www-data /var/www/html/wp-content
chmod -R 777 /var/www/html/wp-content
# Ensure wp-content folder is writable for uploads, plugins, and caching

if ! wp plugin is-installed redis-cache --allow-root --path=/var/www/html; then
    echo "[wordpress]: installing redis-cache..."
    wp plugin install redis-cache --activate --allow-root --path=/var/www/html
    # Install and activate Redis caching plugin if it is not already installed
fi

wp config set WP_REDIS_HOST "redis" --allow-root --path=/var/www/html
# Configure WordPress to use the Redis container as caching backend

if ! wp redis status --allow-root --path=/var/www/html | grep -q "Connected"; then
    wp redis enable --allow-root --path=/var/www/html
    # Enable Redis caching if WordPress is not yet connected to Redis
fi

echo "🚀 Starting php-fpm..."
# Inform that PHP-FPM service is starting

exec /usr/sbin/php-fpm8.4 -F
# Start PHP-FPM in the foreground (-F) to keep Docker container running
# 'exec' replaces this script with php-fpm process as PID 1 inside Docker