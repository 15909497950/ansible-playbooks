#!/bin/bash
erlpid=`ps -ef |grep -w erlang|grep -v grep|wc -l`
if [ $erlpid == 0 ];
then 
echo "erlang already stop"
else
ps -ef |grep -w erlang|grep -v grep|awk '{print $2}'|xargs kill -9
fi