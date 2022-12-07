#!/bin/bash
{{ data_path }}/bin/mysql -uroot -e "GRANT replication slave ON *.* TO 'repl'@'{{ hostvars['master']['ansible_host'] }}' IDENTIFIED BY 'repl' WITH GRANT OPTION;
flush privileges;
quit"
{{ data_path }}/bin/mysql -uroot -e "show master status">{{ data_path }}/slave