#!/bin/bash

pid=`netstat -tunlp |grep 15672 |wc -l`
if [ $pid == 0 ];
then 
echo "rabbitmq already stop"
else
ps -ef |grep -w rabbitmq|grep -v grep|awk '{print $2}'|xargs kill -9
fi
