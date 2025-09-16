FROM debian:trixie-backports
# Use Debian Trixie backports as the base image

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y redis-server redis-tools && \
    rm -rf /var/lib/apt/lists/*
# Update package lists and upgrade existing packages
# Install Redis server and Redis tools
# Clean up apt cache to reduce image size

RUN mkdir -p /run/redis && chmod 755 /run/redis
# Create the /run/redis directory for Redis runtime files
# Set proper permissions for Redis to access it

RUN cp /etc/redis/redis.conf /etc/redis/redis.conf.bak
# Make a backup of the default Redis configuration file

EXPOSE 6379
# Expose Redis default port 6379
# This does not publish the port, it only documents it for users

COPY tools/redis.sh /redis.sh
# Copy the custom Redis startup script into the container

RUN chmod +x /redis.sh
# Make the Redis startup script executable

CMD ["/redis.sh"]
# Set the default command to run the Redis server using the custom script