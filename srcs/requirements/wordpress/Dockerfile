FROM debian:trixie-backports

RUN apt-get update -y && \
 	apt-get install vim -y && \
	apt-get install wget -y && \
	apt-get install -y php8.4 php8.4-fpm php-mysql

COPY tools/script.sh /

RUN chmod +x /script.sh

CMD ["/script.sh"]
