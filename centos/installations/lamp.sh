#!/bin/bash
# references
# https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-centos-7
# Install
yum -y install httpd
# Stop servers
systemctl stop httpd
# FireWalls
firewall-cmd --permanent --add-service=http
firewall-cmd --reload
# Config
## Paths
mkdir -p /var/www/$(hostname)/local/public
chown -R apache:apache /var/www
chmod -R 775 /var/www
## PHP
sed -i 's/= apache/= apache/' /etc/opt/remi/php{54,56,70,72,73}/php-fpm.d/www.conf
sed -i 's/= nobody/= apache/' /etc/opt/remi/php{54,56,70,72,73}/php-fpm.d/www.conf
## Script wrapper
### PHP 5.4
cat > /var/www/cgi-bin/php54.fcgi << EOF
#!/bin/bash
exec /bin/php54-cgi
EOF
### PHP 5.6
cat > /var/www/cgi-bin/php56.fcgi << EOF
#!/bin/bash
exec /bin/php56-cgi
EOF
### PHP 7.0
cat > /var/www/cgi-bin/php70.fcgi << EOF
#!/bin/bash
exec /bin/php70-cgi
EOF
### PHP 7.2
cat > /var/www/cgi-bin/php72.fcgi << EOF
#!/bin/bash
exec /bin/php72-cgi
EOF
### PHP 7.3
cat > /var/www/cgi-bin/php73.fcgi << EOF
#!/bin/bash
exec /bin/php73-cgi
EOF
## Make executable
chmod 755 /var/www/cgi-bin/php*.fcgi
## php configuration for apache, by default php72-fcgi
cat > /etc/httpd/conf.d/php.conf << EOF
ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"
AddHandler php72-fcgi .php
Action php56-fcgi /cgi-bin/php56.fcgi
Action php70-fcgi /cgi-bin/php70.fcgi
Action php72-fcgi /cgi-bin/php72.fcgi
Action php73-fcgi /cgi-bin/php73.fcgi
EOF
# Start server
systemctl restart httpd
systemctl enable httpd
# Proxy file for Chrome
sed -i 's/Exec=\/usr\/bin\/google-chrome-stable/Exec=\/usr\/bin\/google-chrome-stable --proxy-pac-url=file:\/\/\/home\/alograg\/.config\/openbox\/local.pac/' /usr/share/applications/google-chrome.desktop
