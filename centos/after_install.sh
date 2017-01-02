# Update/Upgrade
yum -y update && yum -y upgrade
# Repos
yum -y install epel-release
# Update/Upgrade
yum -y update && yum -y upgrade
# NetToos
yum -y install net-tools
# Links
yum -y install links
# Git
yum --disablerepo=base,updates --enablerepo=rpmforge-extras update git
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
# 7Zip
yum -y install p7zip p7zip-plugins p7zip-gui
# DefaultApps
cat /usr/share/applications/defaults.list | grep video
cat /usr/share/applications/defaults.list | grep image

echo -e "x-scheme-handler/mailto=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "application/pdf=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "image/*=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "audio/x-mpegurl=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/mp4=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/x-flv=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/mpeg=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/webm=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "application/octet-stream=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "audio/x-vorbis+ogg=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/avi=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/flv=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/quicktime=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/vnd.rn-realvideo=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/x-matroska=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/x-ms-asf=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/x-msvideo=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/x-ms-wmv=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/x-ogm=google-chrome.desktop">>.local/share/applications/mimeapps.list
echo -e "video/x-theora=google-chrome.desktop">>.local/share/applications/mimeapps.list

gsettings set org.gnome.desktop.default-applications.office.calendar exec "chromium-browser 'https://www.google.com/calendar'"

# Fonts
yum -y install curl cabextract xorg-x11-font-utils fontconfig
rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
# Reboot
reboot
