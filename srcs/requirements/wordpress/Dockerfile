FROM debian:trixie-backports

RUN apt update && apt install -y \
    php8.4-fpm \
    php8.4-mysqli \
    wget \
    curl \
    unzip \
    ca-certificates \
    default-mysql-client \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

COPY tools/entrypoint.sh /entrypoint.sh
COPY conf/wp-config.php /wp-config.php

RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
