FROM debian:trixie-backports

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y redis-server redis-tools && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/redis && chmod 755 /run/redis

RUN cp /etc/redis/redis.conf /etc/redis/redis.conf.bak

EXPOSE 6379

COPY tools/redis.sh /redis.sh
RUN chmod +x /redis.sh

CMD ["/redis.sh"]
