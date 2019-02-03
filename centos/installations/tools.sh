#!/bin/bash
# Update/Upgrade
yum -y update && yum -y upgrade
# Vim
yum -y install vim
# 7Zip
yum -y install p7zip p7zip-plugins p7zip-gui
# Guake
yum -y install guake
# Fonts
yum -y install curl cabextract xorg-x11-font-utils fontconfig
yum -y install terminus-fonts-console terminus-fonts dejavu-sans-fonts dejavu-fonts-common dejavu-serif-fonts dejavu-sans-mono-fonts open-sans-fonts overpass-fonts liberation-mono-fonts liberation-serif-fonts google-crosextra-caladea-fonts google-crosextra-carlito-fonts 
yum -y install https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
# FiraFont
mkdir -p /usr/share/fonts/Fira
for type in Bold Light Medium Regular Retina; do
    wget -O /usr/share/fonts/Fira/FiraCode-${type}.ttf \
    "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true";
done
fc-cache -f
# NodeJS Version manager
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
# Code
rpm --import https://packages.microsoft.com/keys/microsoft.asc
sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
yum check-update
yum install code
# PHPStorm
wget https://download-cf.jetbrains.com/webide/PhpStorm-2018.3.3.tar.gz
tar xfz PhpStorm-2018.3.3.tar.gz -C /opt/
/opt/PhpStorm-2018.3.3/bin/PhpStorm.sh
