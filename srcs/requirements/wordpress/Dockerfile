FROM debian:trixie-backports
# Use Debian Trixie backports as the base image
# This gives a stable environment with updated packages

RUN apt-get update -y && \
    apt-get install -y \
        vim \
        wget \
        unzip \
        less \
        php8.4 \
        php8.4-fpm \
        php8.4-mysql \
        php8.4-cli \
        php8.4-redis \
        php8.4-curl \
        php8.4-mbstring && \
    rm -rf /var/lib/apt/lists/*
# Update package index
# Install essential tools and PHP 8.4 with necessary extensions:
# - vim: text editor
# - wget: download files from internet
# - unzip: extract zip archives
# - less: view file contents
# - php8.4: PHP language
# - php8.4-fpm: PHP FastCGI Process Manager for Nginx
# - php8.4-mysql: PHP extension to connect to MySQL/MariaDB
# - php8.4-cli: run PHP scripts from the command line
# - php8.4-redis: support for Redis caching
# - php8.4-curl: PHP HTTP client for APIs
# - php8.4-mbstring: handles multi-byte strings (UTF-8)
# Finally, clean up apt cache to reduce image size

COPY tools/script.sh /
# Copy the initialization script into the container at root

RUN chmod +x /script.sh
# Make the script executable so it can run inside the container

EXPOSE 9000
# Expose port 9000 for PHP-FPM to listen on
# This allows Nginx or other services to connect to PHP

CMD ["/script.sh"]
# Set the script as the default command when the container starts
# This script will handle WordPress setup and start PHP-FPM
