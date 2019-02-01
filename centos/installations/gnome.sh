#!/bin/bash
# Update/Upgrade
yum -y update && yum -y upgrade
# XWindow
yum -y groupinstall "X Window System"
# Gnome
yum -y install gnome-classic-session gnome-terminal nautilus-open-terminal control-center liberation-mono-fonts gnome-tweak-tool
unlink /etc/systemd/system/default.target
# ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target
# remve bottom bar
rm -R /usr/share/gnome-shell/extensions/window-list@gnome-shell-extensions.gcampax.github.com
yum -y install gnome-shell-extension-*
