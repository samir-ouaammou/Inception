#!/bin/bash

set -e

useradd -m $FTP_USER -d $FTP_HOME || true

echo -e "$FTP_PASSWORD\n$FTP_PASSWORD" | passwd $FTP_USER

chown -R $FTP_USER:$FTP_USER $FTP_HOME

exec vsftpd /etc/vsftpd.conf
