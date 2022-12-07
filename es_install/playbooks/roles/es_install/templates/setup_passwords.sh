#!/bin/bash

ip="{{ hostvars[inventory_hostname]['ansible_host'] }}"

cd {{ es_worker_path }}/config/
if ! [ -f init_pass ]; then
    {{ es_worker_path }}/bin/elasticsearch-setup-passwords auto -b > init_pass
fi

es_init_pass=$(grep "PASSWORD elastic" init_pass | awk {' print $4 '})
cluster_status=$(curl -u 'elastic:{{ es_user_pass }}' -ks http://$ip:9200/_cluster/health?pretty | grep status | cut -d\" -f4)
if [[ "$cluster_status" = green ]]; then
    echo "no-change"
    exit 0
fi

res=$(curl -sk -XPOST -H 'Content-type: application/json' \
    -u elastic:$es_init_pass \
    -d '{"password":"{{ es_user_pass }}"}' \
    http://$ip:9200/_security/user/elastic/_password)

if [[ "$res" = '{}' ]]; then
    echo "changed"
    exit 0
fi

echo "set password failed"
exit 1
