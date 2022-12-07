#!/bin/bash
port=`netstat -tunlp |grep -v grep |grep 27017|wc -l`
if [ $port == 0 ];then
su app <<EOF
{{ data_path }}/bin/mongod -f {{ data_path }}/etc/mongodb.conf;
EOF
else
echo "maybe mongodb is running" 
fi

