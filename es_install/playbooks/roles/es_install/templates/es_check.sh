#!/bin/bash
#Author: yoson
#Date：2021-04-20
#Desc：

#加载参数
log="{{ es_data_path }}/logs/es_health_check-`date +%Y%m%d`.log"

es_user=elastic
es_pass='{{ es_user_pass }}'
es_port=9200
es_ip="{{ hostvars[inventory_hostname]['ansible_host'] }}"

time=$(date +'%Y-%m-%d %T')
node_count=$(curl -u ${es_user}:"${es_pass}" http://${es_ip}:${es_port}/_cat/nodes?v | grep -c ${es_ip})
if [[ $node_count -eq 0 ]]; then
    echo "${time} start es ${es_ip} 9200" >>$log
    systemctl restart elasticsearch >>$log
else
    echo "${time} es ${es_ip} 9200 ok" >>$log
fi
