#!/bin/bash

# Install Wordpress
yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum --enablerepo=remi-php74 install php php-pdo php-fpm php-gd php-mbstring php-mysql php-curl php-mcrypt php-json -y
php -v
wget https://ru.wordpress.org/latest-ru_RU.zip
unzip latest-ru_RU.zip
cp -r /tmp/homework/wordpress/ /var/www/wordpress/
rm -rf /etc/httpd/conf.d/welcome.conf
cp /tmp/homework/wordpress.conf /etc/httpd/conf.d/
chmod -R 777 /var/www/wordpress/wp-content
chown -R apache. /var/www/wordpress
cp /tmp/homework/wp-config.php /var/www/wordpress/
systemctl restart httpd
