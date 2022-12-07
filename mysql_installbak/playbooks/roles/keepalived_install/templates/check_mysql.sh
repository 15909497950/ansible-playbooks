#!/bin/bash  
pid=`netstat -tunlp |grep 3306 |wc -l`  
if [ $pid -eq 0 ];then  
   /etc/init.d/mysqld start
    sleep 5  
    if [ `netstat -tunlp |grep 3306 |wc -l` -eq 0 ];then  
        pkill keepalived  
    fi  
fi