FROM debian:bullseye

RUN apt-get update -y && \
 	apt-get install vim -y && \
	apt-get install wget -y && \
	apt-get install -y php7.4 php7.4-fpm php-mysql

COPY tools/script.sh /

RUN chmod +x /script.sh

CMD ["/script.sh"]
