#!/bin/bash
# Update/Upgrade
yum -y update && yum -y upgrade
yum clean all
rm -rf /var/cache/yum
rm -rf /var/tmp/yum-*
# SSH secure
echo -e "Protocol 2">>/etc/ssh/ssh_config
echo -e "PermitRootLogin no">>/etc/ssh/ssh_config
systemctl restart sshd.service
yum -y install yum-utils
yum -y install firewalld
