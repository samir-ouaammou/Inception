FROM debian:trixie-backports

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

COPY tools/script.sh /

RUN chmod +x /script.sh

EXPOSE 9000

CMD ["/script.sh"]
