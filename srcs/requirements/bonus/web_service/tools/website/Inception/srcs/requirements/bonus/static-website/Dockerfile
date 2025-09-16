FROM debian:trixie-backports
# Use Debian Trixie backports as the base image

RUN apt-get update -y && apt-get install -y nginx
# Update package lists and install NGINX
# NGINX will serve the static website

COPY index.html /var/www/html/index.html
# Copy your static HTML file from host to container
# This will be the main page served by NGINX

EXPOSE 4242
# Document the port 4242 that this container will listen on
# Note: This doesn't publish the port to the host; docker-compose or run command does that

CMD ["nginx", "-g", "daemon off;"]
# Start NGINX in the foreground (non-daemon mode)
# "-g daemon off;" ensures the container keeps running