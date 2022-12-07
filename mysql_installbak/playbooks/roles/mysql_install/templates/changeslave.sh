#!/bin/bash

file=`awk '{print $1}' {{ data_path }}/master |grep mysql`
pos=`awk '{print $2}' {{ data_path }}/master |sed -n '2p'`
{{ data_path }}/bin/mysql -uroot -e "CHANGE MASTER TO MASTER_HOST='{{ hostvars['master']['ansible_host'] }}',MASTER_USER='repl',MASTER_PASSWORD='repl',MASTER_PORT=3306,MASTER_LOG_FILE='$file',MASTER_LOG_POS=$pos;"
{{ data_path }}/bin/mysql -uroot -e "start slave;"
{{ data_path }}/bin/mysql -uroot -e "alter user 'root'@'localhost' identified by '{{ passwd }}';"
{{ data_path }}/bin/mysql -uroot -p"{{ passwd }}" -e "CREATE user 'root'@'%' identified by '{{ passwd }}';"
{{ data_path }}/bin/mysql -uroot -p"{{ passwd }}" -e "GRANT  ALL  ON  *.*  TO  'root'@'%';"
{{ data_path }}/bin/mysql -uroot -p"{{ passwd }}" -e "CREATE USER  'app'@'%'  IDENTIFIED BY '{{ app_passwd }}';"
{{ data_path }}/bin/mysql -uroot -p"{{ passwd }}" -e "GRANT  ALL  ON  *.*  TO  'app'@'%';"
{{ data_path }}/bin/mysql -uroot -p"{{ passwd }}" -e "flush privileges;"