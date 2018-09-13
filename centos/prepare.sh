#!/bin/bash
# Update/Upgrade
yum -y update && yum -y upgrade
# SSH secure
echo -e "Protocol 2">>/etc/ssh/ssh_config
echo -e "PermitRootLogin no">>/etc/ssh/ssh_config
systemctl restart sshd.service
yum -y install p7zip p7zip-plugins
yum -y install firewalld
