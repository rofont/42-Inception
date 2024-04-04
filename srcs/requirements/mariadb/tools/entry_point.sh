#!/bin/bash

service mysql start;

sleep 10

if [ ! -f "/var/lib/mysql/inception.sql" ]; then

	mysql -u root -p$SQL_ROOT_PASS -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
	mysql -u root -p$SQL_ROOT_PASS -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASS}';"
	mysql -u root -p$SQL_ROOT_PASS -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASS}';"
	mysql -u root -p$SQL_ROOT_PASS -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASS}';"
	mysql -u root -p$SQL_ROOT_PASS -e "FLUSH PRIVILEGES;"

fi

mysqladmin -u root -p$SQL_ROOT_PASS -S /run/mysqld/mysqld.sock shutdown

sleep 5

exec mysqld_safe