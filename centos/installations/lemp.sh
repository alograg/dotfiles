#!/bin/bash
# references
# https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-centos-7
# Install
yum -y install nginx
# Stop servers
systemctl stop nginx
# Install Maira and PHP
./mp.sh
# FireWalls
firewall-cmd --permanent --add-service=http
firewall-cmd --reload
# Configs
## Paths
mkdir -p /var/www/$(hostname)/local/public
chown -R nginx:nginx /var/www
chmod -R 775 /var/www
## Server
cp nginx/* /etc/nginx/conf.d
## PHP
sed -i 's/= apache/= nginx/' /etc/opt/remi/php{54,56,70,72,73}/php-fpm.d/www.conf
sed -i 's/= nobody/= nginx/' /etc/opt/remi/php{54,56,70,72,73}/php-fpm.d/www.conf
# Start server
systemctl restart nginx
systemctl enable nginx
# Proxy file for Chrome
sed -i 's/Exec=\/usr\/bin\/google-chrome-stable/Exec=\/usr\/bin\/google-chrome-stable --proxy-pac-url=file:\/\/\/home\/alograg\/.config\/openbox\/local.pac/' /usr/share/applications/google-chrome.desktop
