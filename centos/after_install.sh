# Update/Upgrade
yum -y update && yum -y upgrade
# NetToos
yum -y install net-tools
# Links
yum -y install links
# Apache/PHP/MariaDb
yum -y install httpd php php-devel php-common php-soap php-gd mariadb-server mariadb
firewall-cmd --add-service=http
firewall-cmd --add-service=mysql
firewall-cmd -permanent -add-port=3221/tcp
firewall-cmd --reload
systemctl restart httpd.service
systemctl start httpd.service
systemctl enable httpd.service
systemctl start mariadb.service
systemctl enable mariadb.service
/usr/bin/mysql_secure_installation
# SSH secure
echo -e "Protocol 2">>/etc/ssh/ssh_config
echo -e "PermitRootLogin no">>/etc/ssh/ssh_config
systemctl restart sshd.service
# GCC
# yum -y install gcc
# NMAp
yum -y install nmap
# XWindow
yum -y groupinstall "X Window System"
yum -y install gnome-classic-session gnome-terminal nautilus-open-terminal control-center liberation-mono-fonts
unlink /etc/systemd/system/default.target
ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target
# Chrome
echo -e "[google-chrome]">/etc/yum.repos.d/google-chrome.repo
echo -e "name=google-chrome">>/etc/yum.repos.d/google-chrome.repo
echo -e "baseurl=http://dl.google.com/linux/chrome/rpm/stable/$basearch">>/etc/yum.repos.d/google-chrome.repo
echo -e "enabled=1">>/etc/yum.repos.d/google-chrome.repo
echo -e "gpgcheck=1">>/etc/yum.repos.d/google-chrome.repo
echo -e "gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub">>/etc/yum.repos.d/google-chrome.repo
yum -y install google-chrome-stable
# NodeJS
curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -
yum -y install nodejs npm
# Repos
yum -y install epel-release
# 7Zip
yum -y install p7zip p7zip-plugins p7zip-gui
# Reboot
reboot
