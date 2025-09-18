FROM debian:trixie-backports
# Use Debian Trixie backports as the base image (provides a clean, lightweight system with access to newer packages)

RUN apt-get update -y && apt-get upgrade -y && \
	apt-get install mariadb-server -y && \
 	apt-get install vim -y
# 1. Update the package index (-y auto-confirms prompts)
# 2. Upgrade all installed packages to the latest versions
# 3. Install MariaDB server (the database engine)
# 4. Install vim for editing/debugging inside the container

COPY conf/50-server.conf	/etc/mysql/mariadb.conf.d/50-server.cnf
# Copy a custom MariaDB configuration file into the official MariaDB config directory
# This allows customizing server settings such as bind-address, character set, or buffer sizes

COPY ./tools/script.sh /
# Copy the initialization script (script.sh) into the container root
# This script will handle database setup (users, passwords, databases) and start the MariaDB service

RUN chmod +x /script.sh
# Make the script executable so it can be run inside the container

CMD ["/script.sh"]
# Set the default command to run when the container starts
# This script will configure and launch MariaDB, keeping the container alive