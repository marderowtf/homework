#!/bin/bash

# Mysql script for backup

PATH=$PATH:/usr/local/bin

DIR=`date +"%Y-%m-%d"`
DATE=`date +"%Y%m%d"`
MYSQL='mysql --defaults-extra-file=/home/root/user.cnf --skip-column-names'

for skull in `$MYSQL -e "SHOW DATABASES"`;
do
	if [ $skull != "information_schema" ] && [ $skull != "mysql" ] && [ $skull != "sys" ] && [ $skull != "performance_schema" ]; then
		for table in `$MYSQL $skull -e "SHOW TABLES"`;
		do	
		    mkdir -p $skull
		/usr/bin/mysqldump --defaults-extra-file=/home/mardero/user.cnf --add-drop-table --add-locks --create-options --disable-keys --extended-insert --single-transaction --quick --set-charset --events --routines --triggers --master-data $skull $table | gzip -1 > $skull/$table.gz;	
		done
	fi
done
