# Use Debian Trixie backports as the base image
FROM debian:trixie-backports

# Update the package lists for upgrades and new packages
RUN apt-get update

# Install PHP
RUN apt-get install -y php

# Install PHP MySQLi extension for database access
RUN apt-get install -y php-mysqli

# Install wget to download files from the internet
RUN apt-get install -y wget

# Copy the adminer.sh script from the local tools folder to the container root
COPY tools/adminer.sh /

# Make the script executable
RUN chmod +x /adminer.sh

# Inform Docker that the container will listen on port 8080
EXPOSE 8080

# Default command to run when the container starts (launch the Adminer script)
CMD [ "/adminer.sh" ]
