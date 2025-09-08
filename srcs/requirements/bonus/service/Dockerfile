FROM debian:bookworm

RUN apt-get update -y && apt-get install -y nginx

COPY index.html /var/www/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
