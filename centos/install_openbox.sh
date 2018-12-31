#!/bin/bash
# Update/Upgrade
yum -y update && yum -y upgrade
# Repos
yum -y install epel-release
# Update/Upgrade
yum -y update && yum -y upgrade
# NetToos
yum -y install net-tools
# Desactivate SELinux
#vi /etc/sysconfig
# Git
yum -y install http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-2.noarch.rpm
yum -y update git
# X XWindow
yum -y groupinstall "X Window System"
systemctl set-default graphical.target
# 7Zip
yum -y install p7zip p7zip-plugins p7zip-gui
# https://www.devpy.me/your-guide-to-a-comfortable-linux-desktop-with-openbox/
# https://ramsdenj.com/2016/03/28/building-a-custom-linux-environment-with-openbox.html
# https://fedoramagazine.org/openbox-fedora/
# https://arrfab.net/posts/2018/Jan/02/lightweigth-centos-7-i686-desktop-on-older-machine/
# Reboot
reboot
