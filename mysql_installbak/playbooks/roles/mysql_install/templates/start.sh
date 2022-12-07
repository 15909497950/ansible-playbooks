#!/bin/bash
port=`netstat -tunlp |grep -v grep |grep 3306|wc -l`
if [ $port == 0 ];then
rm -rf {{ data_path }}/data/*
{{ data_path }}/bin/mysqld --initialize-insecure --user=app
su - app -c "/etc/init.d/mysqld start"
else
echo "mysql is running"
fi

