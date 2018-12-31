#!/bin/bash
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
yum -y install http://opensource.wandisco.com/centos/6/git/x86_64/wandisco-git-release-6-1.noarch.rpm
yum -y install git
# Apache/PHP/MariaDb
yum -y install httpd php php-devel php-common php-soap php-gd mariadb-server mariadb
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=mysql
firewall-cmd --permanent --add-port=3221/tcp
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
yum -y install gnome-classic-session gnome-terminal nautilus-open-terminal control-center liberation-mono-fonts gnome-tweak-tool
unlink /etc/systemd/system/default.target
ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target
# remve bottom bar
rm -R /usr/share/gnome-shell/extensions/window-list@gnome-shell-extensions.gcampax.github.com
yum -y install gnome-shell-extension-*
# Chrome
#echo -e "[google-chrome]">/etc/yum.repos.d/google-chrome.repo
#echo -e "name=google-chrome">>/etc/yum.repos.d/google-chrome.repo
#echo -e "baseurl=http://dl.google.com/linux/chrome/rpm/stable/$basearch">>/etc/yum.repos.d/google-chrome.repo
#echo -e "enabled=1">>/etc/yum.repos.d/google-chrome.repo
#echo -e "gpgcheck=1">>/etc/yum.repos.d/google-chrome.repo
#echo -e "gpgkey=https://dlssl.google.com/linux/linux_signing_key.pub">>/etc/yum.repos.d/google-chrome.repo
#yum -y install google-chrome-stable
curl https://intoli.com/install-google-chrome.sh | bash
# NodeJS Version manager
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
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
yum -y install https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
# FiraFont
mkdir -p /usr/share/fonts/Fira
for type in Bold Light Medium Regular Retina; do
    wget -O /usr/share/fonts/Fira/FiraCode-${type}.ttf \
    "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true";
done
fc-cache -f
# vscoder
rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
yum check-update
yum -y install code
# Reboot
reboot
