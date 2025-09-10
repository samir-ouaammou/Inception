FROM debian:trixie-backports

RUN apt-get update -y && apt-get install -y nginx

COPY index.html /var/www/html/index.html

EXPOSE 4242

CMD ["nginx", "-g", "daemon off;"]
