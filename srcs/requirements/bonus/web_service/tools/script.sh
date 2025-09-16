#!/bin/bash
# Shebang: specifies that this script should be run with bash

chmod -R 755 /var/www/html
# Recursively set permissions of all files and directories in /var/www/html
# 7 = read/write/execute for owner
# 5 = read/execute for group
# 5 = read/execute for others
# Ensures NGINX can read files and directories properly

nginx -g "daemon off;"
# Start NGINX in the foreground
# "-g daemon off;" prevents NGINX from running as a background daemon
# Necessary for Docker to keep the container running
