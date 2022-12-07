#!/bin/bash
es_ip='{{ hostvars[inventory_hostname]['ansible_host'] }}'
es_user=elastic
es_pass='{{ es_user_pass }}'
es_port=9200

#指定日期(3个月前)
endDay=$(date -d "3 month ago" +%Y%m%d)
echo ${endDay}
indices=$(curl -u ${es_user}:"${es_pass}" -XGET "http://${es_ip}:${es_port}/_cat/indices" |grep  -E 'tmf-console|tmf-alarm'| awk '{print $3}')
log={{ es_data_path }}/logs/es_clean_log-`date +%Y%m%d`.log

for index in ${indices[*]}; do
    indexTime=${index##*-}
    year=$(echo ${indexTime} | cut -d "." -f1)
    month=$(echo ${indexTime} | cut -d "." -f2)
    day=$(echo ${indexTime} | cut -d "." -f3)

    if ! [[ -n $day ]]; then
        echo "ignore index:$index"
        continue
    fi

    indexDay=$(date -d "$year$month$day" +%Y%m%d)
    if [[ $indexDay -lt $endDay ]]; then
        echo "$(date '+%F %T') Delete index:$index" >> $log
        curl -u ${es_user}:"${es_pass}" -XDELETE "http://${es_ip}:${es_port}/$index" >> $log
    else
        echo "Ingore index:$index" >> $log
    fi
done
