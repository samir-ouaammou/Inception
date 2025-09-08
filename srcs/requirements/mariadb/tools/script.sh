#!/bin/bash

mysqld_safe &
db_pid=$!

while ! mysqladmin ping --silent; do
    sleep 1
done

mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<STOP
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
STOP

kill "$db_pid"
wait "$db_pid" 2>/dev/null

echo "🚀 Starting mysql..."
exec mysqld_safe
