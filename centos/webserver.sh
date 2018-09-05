#!/bin/bash
# Update/Upgrade
yum -y update && yum -y upgrade
# Repos
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum -y install epel-release
# Install
yum install httpd -y
yum install yum-utils -y
yum install php56 -y
yum install php72 -y
yum install php56-php-fpm -y
yum install php72-php-fpm -y
# Stop servers
systemctl stop php56-php-fpm
systemctl stop php72-php-fpm
# Change port of PHP server
sed -i 's/:9000/:9056/' /etc/opt/remi/php56/php-fpm.d/www.conf
sed -i 's/:9000/:9072/' /etc/opt/remi/php72/php-fpm.d/www.conf
# vi /etc/sysconfig/selinux
# SELINUXTYPE=targeted
# Stqrt server
systemctl start php72-php-fpm
systemctl start php56-php-fpm
# Script wrapper PHP 5.6
cat > /var/www/cgi-bin/php56.fcgi << EOF
#!/bin/bash
exec /bin/php56-cgi
EOF
# Script wrapper PHP 7.2
cat > /var/www/cgi-bin/php72.fcgi << EOF
#!/bin/bash
exec /bin/php72-cgi
EOF
# Make executable
chmod 755 /var/www/cgi-bin/php56.fcgi
chmod 755 /var/www/cgi-bin/php72.fcgi
# php configuration for apache, by default php56-fcgi
cat > /etc/httpd/conf.d/php.conf << EOF
ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"
AddHandler php56-fcgi .php
Action php56-fcgi /cgi-bin/php56.fcgi
Action php72-fcgi /cgi-bin/php72.fcgi
EOF
systemctl enable httpd
systemctl enable php56-php-fpm
systemctl enable php72-php-fpm
