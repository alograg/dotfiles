#!/bin/bash
# Update/Upgrade
yum -y update && yum -y upgrade
# X XWindow
yum -y groupinstall "X Window System"
# OpenBox
yum -y install openbox obconf-qt obmenu pcmanfm-qt
mkdir -pv ~/.config/openbox
cp -v /etc/xdg/openbox/* ~/.config/openbox
echo -e "exec openbox-session" >> ~/.xinitrc
