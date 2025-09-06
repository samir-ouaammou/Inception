FROM debian:trixie-backports

RUN apt update && apt install -y mariadb-server && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/mysql

COPY tools/mariadb.sh /mariadb.sh
COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/

RUN chmod +x /mariadb.sh

VOLUME ["/var/lib/mysql"]

CMD ["/mariadb.sh"]
