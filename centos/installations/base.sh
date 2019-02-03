#!/bin/bash
# Update/Upgrade
yum -y update && yum -y upgrade
# Repos
yum -y install epel-release
yum -y install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
# Update/Upgrade
yum -y update && yum -y upgrade
# YUM Utils
yum install yum-utils
# NetToos
yum -y install net-tools
# Git
yum -y install git
git config --global core.fileMode false
# wGet
yum -y install wget
# Set Enforce
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
# SELINUX=disabled
