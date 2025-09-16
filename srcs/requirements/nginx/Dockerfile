FROM debian:trixie-backports
# Use Debian Trixie backports as the base image for stability and latest packages

RUN apt-get update -y && apt-get install nginx -y && \
	apt-get install openssl -y && \
 	apt-get install vim -y
# Update package list and install:
# - nginx: the web server
# - openssl: to generate TLS/SSL certificates
# - vim: text editor (optional, useful for editing inside container)

RUN mkdir -p /etc/nginx/ssl \
	&& openssl req -x509 -nodes \
	-out /etc/nginx/ssl/inception.crt \
	-keyout /etc/nginx/ssl/inception.key \
	-subj "/C=MR/L=Benguerir/O=42/OU=1337/UID=samir/CN=souaammo.42.fr"
# 1. Create directory for SSL certificates
# 2. Generate a self-signed TLS certificate and private key:
#    - -x509: generate X.509 certificate
#    - -nodes: do not encrypt private key
#    - -out: path to save the certificate
#    - -keyout: path to save the private key
#    - -subj: set certificate details (country, location, org, etc.)

COPY conf/default.conf /etc/nginx/nginx.conf
# Copy custom NGINX configuration into container to configure server blocks, SSL, and reverse proxy settings

CMD [ "nginx", "-g", "daemon off;" ]
# Run NGINX in the foreground so Docker can manage the container lifecycle
# -g "daemon off;": prevents NGINX from running as a background daemon
