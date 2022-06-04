# homework

1.Загрузить и запустить скрипт soft.sh (yum -y install epel-release wget unzip nano mc gzip git)
Прописать для скриптов chmod 755
#################################
# Для всех серваков
2. Github git init, git clone https://github.com/marderowtf/homework.git и загрузить репозиторий
#################################
# mysql master
3.Загрузить запустить скрипт 1-nginx-apache.sh
#################################
4.На мастере Загрузить и запустить скрипт 2-mysql-master.sh
#################################
# Для всех серваков
5.Узнать временный пароль grep "A temporary password" /var/log/mysqld.log
#################################
6. Меняем пароль mysql_secure_installation mysql -uroot -p
#################################
# mysql master
7.Запустить скрипт 2-1-mysql-master.sh (SELECT User, Host FROM mysql.user;)
#################################
# mysql slave
8.На слейве Загрузить и запустить скрипт 3-mysql-slave.sh
#################################
9.На слейве запустить скрипт 3-1-mysql-slave.sh
#################################
# mysql slave
nano /etc/my.cnf (server_id = 2)
systemctl restart mysqld
STOP SLAVE;
CHANGE MASTER TO MASTER_HOST='192.168.8.12', MASTER_USER='repl', MASTER_PASSWORD='oTUSlave#2020', MASTER_LOG_FILE='binlog.000005', MASTER_LOG_POS=688, GET_MASTER_PUBLIC_KEY = 1;
START SLAVE;
show slave status\G

10.Так же на слейве Загрузить и запустить скрипт mysql-script.sh (это скрипт бэкапа) При необходимости залить конфиг user.cnf (/root/user.cnf)
#################################
# mysql master
14.На мастере запустить скрипт 4-cms.sh (Установка Wordpress)
#################################
15.На мастере запустить скрипт 5-mysql-cms.sh (Установка БД для Wordpress)
#################################
16.Проверить работу Wordpress через http://ip:8080/wp-admin 
#################################
# mysql slave
17.Загрузить и запустить скрипт 6-prometheus.sh (Мониторинг)
#################################
18.Проверить прометеуса через http://ip adress:9090
#################################
19.Проверить нода через http://ip adress:9100/metrics
#################################
20.Графана http://ip adress:3000
#################################
# mysql master
21.Где стоит Nginx запустить скрипт 7-nginx-prometheus.sh
#################################
https://www.observability.blog/nginx-monitoring-with-prometheus/
22.Скопировать готовый сервис /etc/systemd/system/node_exporter.service

http://localhost:9090
1860 (prometheus)
12708 (nginx exporter)
