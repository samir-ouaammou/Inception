#!/bin/bash
# Shebang: tells the system to run this script using Bash

mkdir -p /adminer
# Create /adminer directory if it doesn't exist; no error if it already exists

wget https://www.adminer.org/latest.php -O /adminer/index.php 
# Download the latest Adminer PHP file from the official website and save it as /adminer/index.php

chmod +r /adminer/index.php
# Give read permission to index.php so any process can read it

php -S 0.0.0.0:8080 -t /adminer
# Start PHP built-in server listening on all interfaces (0.0.0.0) at port 8080
# Set /adminer as the document root (folder containing files to serve)
