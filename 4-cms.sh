#!/bin/bash

# Install Wordpress
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum --enablerepo=remi-php74 install php php-pdo php-fpm php-gd php-mbstring php-mysql php-curl php-mcrypt php-json -y
php -v
wget https://ru.wordpress.org/latest-ru_RU.zip
unzip latest-ru_RU.zip
cp -r /tmp/homework/wordpress/ /var/www/wordpress/
chmod -R 777 /var/www/wordpress/wp-content
chown -R apache. /var/www/wordpress
systemctl restart httpd