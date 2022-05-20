#!/bin/bash

# Mysql Create user to master
cp /tmp/homework/my.cnf /etc/
mysql <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH 'caching_sha2_password' BY 'G@pbnbd!23';
CREATE USER repl@'%' IDENTIFIED WITH 'caching_sha2_password' BY 'oTUSlave#2020';
GRANT REPLICATION SLAVE ON *.* TO repl@'%';
SHOW MASTER STATUS;
EOF