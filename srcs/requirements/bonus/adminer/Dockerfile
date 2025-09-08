FROM debian:trixie-backports

RUN apt-get update

RUN apt-get install -y php

RUN apt-get install -y php-mysqli

RUN apt-get install -y wget

COPY tools/adminer.sh /

RUN chmod +x /adminer.sh

EXPOSE 8080

CMD [ "/adminer.sh" ]
