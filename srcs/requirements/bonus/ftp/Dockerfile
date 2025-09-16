FROM debian:trixie-backports
# Use Debian Trixie backports as the base image

RUN apt-get update && apt-get install -y vsftpd
# Update the package list and install vsftpd (FTP server) with automatic yes to prompts

COPY conf/vsftpd.conf /etc/vsftpd.conf
# Copy the custom vsftpd configuration file from host to container

COPY tools/ftp.sh /ftp.sh
# Copy the startup script into the container

RUN chmod +x /ftp.sh
# Make the startup script executable

EXPOSE 21
# Expose port 21 so the container can accept FTP connections

CMD ["/ftp.sh"]
# Set the startup script as the default command to run when the container starts
