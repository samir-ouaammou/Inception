#!/bin/bash
# Specify that this script should be run with Bash shell

redis-server --protected-mode no --bind 0.0.0.0
# Start the Redis server
# --protected-mode no : disable Redis protected mode so it can accept external connections
# --bind 0.0.0.0      : allow Redis to listen on all network interfaces