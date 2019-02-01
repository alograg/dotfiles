#!/bin/bash
# references
# https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-centos-7
# Apache
yum -y install httpd
# Database
## MariaDB
yum -y install mariadb-server mariadb MariaDB-client
## MySQL
#yum -y install https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
#rpm -Uvh http://mirror.webtatic.com/yum/el5/latest.rpm
#yum -y install http://repo.mysql.com/yum/mysql-5.5-community/el/7/x86_64/mysql-community-release-el7-5.noarch.rpm
#yum install -y mysql-community-server
#service mysqld start
mysql_secure_installation
## Add user
mysql -p -B -e "CREATE USER 'alograg'@'%';" mysql
mysql -p -B -e "GRANT ALL PRIVILEGES ON *.* To 'alograg'@'%' IDENTIFIED BY '';" mysql
mysql -p -B -e "FLUSH privileges;;" mysql
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
yum install -y php54 php54-php-bcmath php54-php-cli php54-php-common php54-php-devel php54-php-fpm php54-php-gd php54-php-imap php54-php-intl php54-php-mbstring php54-php-mcrypt php54-php-mysqlnd php54-php-pdo php54-php-pear php54-php-pecl-memcache php54-php-process php54-php-soap php54-php-sqlite php54-php-xml php54-php-ioncube-loader
yum install -y php56 php56-php-bcmath php56-php-cli php56-php-common php56-php-devel php56-php-fpm php56-php-gd php56-php-imap php56-php-intl php56-php-mbstring php56-php-mcrypt php56-php-mysqlnd php56-php-pdo php56-php-pear php56-php-pecl-memcache php56-php-process php56-php-soap php56-php-sqlite php56-php-xml php56-php-ioncube-loader
yum install -y php70 php70-php-bcmath php70-php-cli php70-php-common php70-php-devel php70-php-fpm php70-php-gd php70-php-imap php70-php-intl php70-php-mbstring php70-php-mcrypt php70-php-mysqlnd php70-php-pdo php70-php-pear php70-php-pecl-memcache php70-php-process php70-php-soap php70-php-sqlite php70-php-xml php70-php-ioncube-loader
yum install -y php72 php72-php-bcmath php72-php-cli php72-php-common php72-php-devel php72-php-fpm php72-php-gd php72-php-imap php72-php-intl php72-php-mbstring php72-php-mcrypt php72-php-mysqlnd php72-php-pdo php72-php-pear php72-php-pecl-memcache php72-php-process php72-php-soap php72-php-sqlite php72-php-xml php72-php-ioncube-loader
# Stop servers
systemctl stop nginx
systemctl stop httpd
systemctl stop php54-php-fpm
systemctl stop php56-php-fpm
systemctl stop php70-php-fpm
systemctl stop php72-php-fpm
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
sed -i 's/= apache/= nginx/' /etc/opt/remi/php54/php-fpm.d/www.conf
sed -i 's/= apache/= nginx/' /etc/opt/remi/php56/php-fpm.d/www.conf
sed -i 's/= apache/= nginx/' /etc/opt/remi/php70/php-fpm.d/www.conf
sed -i 's/= apache/= nginx/' /etc/opt/remi/php72/php-fpm.d/www.conf
sed -i 's/= nobody/= nginx/' /etc/opt/remi/php54/php-fpm.d/www.conf
sed -i 's/= nobody/= nginx/' /etc/opt/remi/php56/php-fpm.d/www.conf
sed -i 's/= nobody/= nginx/' /etc/opt/remi/php70/php-fpm.d/www.conf
sed -i 's/= nobody/= nginx/' /etc/opt/remi/php72/php-fpm.d/www.conf
# Apache Config
## Script wrapper PHP 5.4
cat > /var/www/cgi-bin/php54.fcgi << EOF
#!/bin/bash
exec /bin/php54-cgi
EOF
## Script wrapper PHP 5.6
cat > /var/www/cgi-bin/php56.fcgi << EOF
#!/bin/bash
exec /bin/php56-cgi
EOF
## Script wrapper PHP 7.0
cat > /var/www/cgi-bin/php70.fcgi << EOF
#!/bin/bash
exec /bin/php70-cgi
EOF
## Script wrapper PHP 7.2
cat > /var/www/cgi-bin/php72.fcgi << EOF
#!/bin/bash
exec /bin/php72-cgi
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
EOF
# Start server
systemctl restart php{54,56,70,72}-php-fpm
systemctl restart mysqld
systemctl restart httpd
systemctl enable httpd
systemctl enable mysqld
systemctl enable php{54,56,70,72}-php-fpm
