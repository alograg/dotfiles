#!/bin/bash
# references
# https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-centos-7
# Repos
yum -y install epel-release
yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
# Install
yum -y install p7zip p7zip-plugins unzip zip
## Apache
#yum install httpd -y
## Nginx
yum install nginx -y
# Database
## MariaDB
yum install mariadb-server mariadb MariaDB-client -y
service mariadb start
mysql_secure_installation
## Add user
mysql -u root -p -B -e "CREATE USER 'local_user'@'%';" mysql
mysql -u root -p -B -e "GRANT ALL PRIVILEGES ON *.* To 'local_user'@'%' IDENTIFIED BY 'local';" mysql
mysql -u root -p -B -e "FLUSH privileges;" mysql
# PHP MultiVersions
# phpVV
# phpVV-php-bcmath
# phpVV-php-cli
# phpVV-php-common
# phpVV-php-devel
# phpVV-php-fpm
# phpVV-php-gd
# phpVV-php-imap
# phpVV-php-intl
# phpVV-php-mbstring
# phpVV-php-mcrypt
# phpVV-php-mysqlnd
# phpVV-php-pdo
# phpVV-php-pear
# phpVV-php-pecl-memcache
# phpVV-php-process
# phpVV-php-soap
# phpVV-php-sqlite
# phpVV-php-xml
yum install -y php{54,56,70,72} php{54,56,70,72}-php-bcmath php{54,56,70,72}-php-cli php{54,56,70,72}-php-common php{54,56,70,72}-php-devel php{54,56,70,72}-php-fpm php{54,56,70,72}-php-gd php{54,56,70,72}-php-imap php{54,56,70,72}-php-intl php{54,56,70,72}-php-mbstring php{54,56,70,72}-php-mcrypt php{54,56,70,72}-php-mysqlnd php{54,56,70,72}-php-pdo php{54,56,70,72}-php-pear php{54,56,70,72}-php-pecl-memcache php{54,56,70,72}-php-process php{54,56,70,72}-php-soap php{54,56,70,72}-php-sqlite php{54,56,70,72}-php-xml php{54,56,70,72}-php-ioncube-loader php{54,56,70,72}-php-pecl-xdebug php{54,56,70,72}-php-pecl-zip
# Stop servers
systemctl stop nginx
systemctl stop php{54,56,70,72}-php-fpm
# Set Enforce
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
# SELINUX=disabled
# FireWalls
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=mysql
firewall-cmd --permanent --add-port=3221/tcp
firewall-cmd --reload
# Add php54
cd /etc/opt/remi/
ln -s /opt/remi/php54/root/etc/ php54
# Change port of PHP server
sed -i 's/:9000/:9054/' /etc/opt/remi/php54/php-fpm.d/www.conf
sed -i 's/:9000/:9056/' /etc/opt/remi/php56/php-fpm.d/www.conf
sed -i 's/:9000/:9070/' /etc/opt/remi/php70/php-fpm.d/www.conf
sed -i 's/:9000/:9072/' /etc/opt/remi/php72/php-fpm.d/www.conf
## Nginx
sed -i 's/= apache/= nginx/' /etc/opt/remi/phpphp{54,56,70,72}-php-fpm/php-fpm.d/www.conf
sed -i 's/= nobody/= nginx/' /etc/opt/remi/phpphp{54,56,70,72}-php-fpm/php-fpm.d/www.conf
# Nginx Config
#http://local.artebeaute.test/
mkdir -p /var/www/$(hostname)/local/public
chown -R nginx:nginx /var/www
chmod -R 775 /var/www
cp nginx/* /etc/nginx/conf.d
# Start server
systemctl restart php{54,56,70,72}-php-fpm
systemctl restart mariadb
systemctl restart nginx
systemctl enable nginx
systemctl enable mariadb
systemctl enable php{54,56,70,72}-php-fpm
