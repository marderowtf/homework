#!/bin/bash
# Install Nginx and Apache
yum -y install epel-release nginx httpd
# Start Nginx and Apache
cp /tmp/homework/httpd.conf /etc/httpd/conf/httpd.conf
cp /tmp/homework/nginx_upstream.conf /etc/nginx/conf.d/
systemctl start nginx
systemctl enable nginx
systemctl start httpd
systemctl enable httpd
# Off SElinux
setenforce 0
# Off firewall
systemctl stop firewalld
systemctl disable firewalld