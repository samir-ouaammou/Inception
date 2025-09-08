FROM debian:trixie-backports

RUN apt-get update && apt-get install -y vsftpd

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/ftp.sh /ftp.sh

RUN chmod +x /ftp.sh

EXPOSE 21

CMD ["/ftp.sh"]
