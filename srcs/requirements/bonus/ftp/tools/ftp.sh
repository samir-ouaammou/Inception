#!/bin/bash
# Use Bash shell to execute this script

set -e
# Exit immediately if any command returns a non-zero status (fail-safe)

useradd -m $FTP_USER -d $FTP_HOME || true
# Create a new user with home directory $FTP_HOME
# -m: create the home directory if it doesn't exist
# -d $FTP_HOME: set the home directory path
# || true: ignore error if user already exists

echo -e "$FTP_PASSWORD\n$FTP_PASSWORD" | passwd $FTP_USER
# Set the password for the new user
# echo -e prints the password twice (for confirmation)
# Pipe it to 'passwd' to assign the password

chown -R $FTP_USER:$FTP_USER $FTP_HOME
# Change ownership of the home directory to the new user
# -R: recursively apply to all files and folders

exec vsftpd /etc/vsftpd.conf
# Start the FTP server with the specified configuration file
# 'exec' replaces the current shell with vsftpd process so Docker container runs in foreground
