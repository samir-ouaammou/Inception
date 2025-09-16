FROM debian:trixie-backports
# Use Debian Trixie backports as the base image

RUN apt-get update
# Update the package lists for upgrades and new packages

RUN apt-get install -y php
# Install PHP

RUN apt-get install -y php-mysqli
# Install PHP MySQLi extension for database access

RUN apt-get install -y wget
# Install wget to download files from the internet

COPY tools/adminer.sh /
# Copy the adminer.sh script from the local tools folder to the container root

RUN chmod +x /adminer.sh
# Make the script executable

EXPOSE 8080
# Inform Docker that the container will listen on port 8080

CMD [ "/adminer.sh" ]
# Default command to run when the container starts (launch the Adminer script)
