#!/bin/bash

# Mysql Create db, user to slave
cp /tmp/homework/my.cnf /etc/
mysql <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH 'caching_sha2_password' BY 'G@pbnbd!23';
CREATE USER repl@'%' IDENTIFIED WITH 'caching_sha2_password' BY 'oTUSlave#2020';
GRANT REPLICATION SLAVE ON *.* TO repl@'%';
SELECT User, Host FROM mysql.user;
SHOW MASTER STATUS;
SHOW DATABASES;
EOF