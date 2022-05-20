#!/bin/bash
#Install mysql
rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
rpm -Uvh https://repo.mysql.com/mysql80-community-release-el7-3.noarch.rpm
sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/mysql-community.repo
yum -y --enablerepo=mysql80-community install mysql-community-server
systemctl start mysqld
systemctl enable mysqld
hostnamectl set-hostname mysql-master
cp /tmp/my.cnf /etc/