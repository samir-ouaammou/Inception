#!/bin/bash
# Use Bash shell to execute this script

mysqld_safe &
# Start MariaDB server in the background using 'mysqld_safe' (safe startup wrapper)
# '&' means run in background so the script can continue

db_pid=$!
# Save the Process ID (PID) of the last background command (MariaDB) into variable db_pid

while ! mysqladmin ping --silent; do
    sleep 1
done
# Keep checking if MariaDB server is ready
# 'mysqladmin ping' verifies if the server is alive
# '--silent' hides extra output
# If not ready, wait 1 second and try again

mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<STOP
# Connect to MariaDB as root user using password from environment variable MYSQL_ROOT_PASSWORD
# The following SQL commands will be executed until the 'STOP' marker

CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
# -- Create the database (name from MYSQL_DATABASE) if it doesn't already exist

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
# -- Create a new user with MYSQL_USER and MYSQL_PASSWORD
# -- '@'%' allows this user to connect from any host (not just localhost)

GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
# -- Grant full privileges on this database to the created user

FLUSH PRIVILEGES;
# -- Reload privileges to apply changes immediately

STOP
# End of SQL commands block

kill "$db_pid"
# Stop the temporary MariaDB process that was started at the beginning

wait "$db_pid" 2>/dev/null
# Wait for the MariaDB process to fully shut down
# Redirect errors to /dev/null to avoid showing "no such process" messages

exec mysqld_safe
# Start MariaDB server again in the foreground as the main container process
# 'exec' replaces the script with the mysqld_safe process (PID 1 in Docker)