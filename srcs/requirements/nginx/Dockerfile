FROM debian:trixie-backports

RUN apt update && apt install -y nginx openssl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

COPY tools/nginx.sh /nginx.sh
COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod +x /nginx.sh

CMD ["/nginx.sh"]
