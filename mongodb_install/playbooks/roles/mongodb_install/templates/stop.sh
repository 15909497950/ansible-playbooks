#!/bin/bash
port=`netstat -tunlp |grep -v grep |grep 27017|wc -l`
if [ $port == 0 ];then
echo "maybe mongodb is already stop"
else
{{ data_path }}/bin/mongod --shutdown --dbpath {{ data_path }}/data/
fi
