FROM debian:trixie-backports
# Use Debian Trixie backports as the base image

RUN apt-get update -y && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*
# Update package index, install NGINX, then clean up apt cache to reduce image size

COPY tools/website /var/www/html
# Copy static website files from host to container's web root

COPY conf/nginx.conf /etc/nginx/sites-available/default
# Replace default NGINX configuration with custom config

COPY tools/script.sh /
# Copy the startup script into the container

RUN chmod +x /script.sh
# Make the startup script executable

EXPOSE 1337
# Expose port 1337 to allow access to the service

CMD ["/script.sh"]
# Set the startup script as the command to run when the container starts
