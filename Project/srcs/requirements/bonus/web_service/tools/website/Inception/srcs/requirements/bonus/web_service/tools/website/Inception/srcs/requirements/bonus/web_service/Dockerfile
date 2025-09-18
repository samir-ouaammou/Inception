FROM debian:trixie-backports

RUN apt-get update -y && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

COPY tools/website /var/www/html

COPY conf/nginx.conf /etc/nginx/sites-available/default

COPY tools/script.sh /

RUN chmod +x /script.sh

EXPOSE 1337

CMD ["/script.sh"]
