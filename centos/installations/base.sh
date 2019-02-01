#!/bin/bash
# Update/Upgrade
yum -y update && yum -y upgrade
# Repos
yum -y install epel-release
# Update/Upgrade
yum -y update && yum -y upgrade
# NetToos
yum -y install net-tools
# Git
yum -y install git
# wGet
yum -y install wget
# Set Enforce
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
# SELINUX=disabled
