#!/bin/bash
# Database
## MariaDB
yum -y install mariadb-server mariadb MariaDB-client
systemctl start mysql.service
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
yum install -y php{54,56,70,72,73} php{54,56,70,72,73}-php-bcmath php{54,56,70,72,73}-php-cli php{54,56,70,72,73}-php-common php{54,56,70,72,73}-php-devel php{54,56,70,72,73}-php-fpm php{54,56,70,72,73}-php-gd php{54,56,70,72,73}-php-imap php{54,56,70,72,73}-php-intl php{54,56,70,72,73}-php-mbstring php{54,56,70,72,73}-php-mcrypt php{54,56,70,72,73}-php-mysqlnd php{54,56,70,72,73}-php-pdo php{54,56,70,72,73}-php-pear php{54,56,70,72,73}-php-pecl-memcache php{54,56,70,72,73}-php-process php{54,56,70,72,73}-php-soap php{54,56,70,72,73}-php-sqlite php{54,56,70,72,73}-php-xml php{54,56,70,72,73}-php-ioncube-loader php{54,56,70,72,73}-php-pecl-xdebug php{54,56,70,72,73}-php-pecl-zip
# Stop servers
systemctl stop php{54,56,70,72,73}-php-fpm
firewall-cmd --permanent --add-service=mysql
firewall-cmd --permanent --add-port=3221/tcp
firewall-cmd --reload
# Add php54
BASEDIR=$(dirname "$0")
cd /etc/opt/remi/
ln -s /opt/remi/php54/root/etc/ php54
cd "$BASEDIR"
# Change port of PHP server
sed -i 's/:9000/:9054/' /etc/opt/remi/php54/php-fpm.d/www.conf
sed -i 's/:9000/:9056/' /etc/opt/remi/php56/php-fpm.d/www.conf
sed -i 's/:9000/:9070/' /etc/opt/remi/php70/php-fpm.d/www.conf
sed -i 's/:9000/:9072/' /etc/opt/remi/php72/php-fpm.d/www.conf
sed -i 's/:9000/:9073/' /etc/opt/remi/php73/php-fpm.d/www.conf
# Start server
systemctl restart php{54,56,70,72,73}-php-fpm
systemctl restart mariadb
systemctl enable mariadb
systemctl enable php{54,56,70,72,73}-php-fpm
