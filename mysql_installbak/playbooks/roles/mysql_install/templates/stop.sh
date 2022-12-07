#!/bin/bash
port=`netstat -tunlp |grep -v grep |grep 3306|wc -l`
if [ $port == 0 ];then
echo "mysql is already stop"
exit 1
else
ps -ef |grep 3306|grep -v grep|awk '{print $2}'|xargs kill -9
ps -ef |grep -w mysqld_safe |grep -v grep|awk '{print $2}'|xargs kill -9
fi
