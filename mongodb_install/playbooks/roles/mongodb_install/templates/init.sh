#!/bin/bash
{{ data_path }}/bin/mongo --host {{ hostvars['master']['ansible_host'] }} --port 27017 --eval "config = {_id:'osmongodb',members: [{_id: 0, host: '{{ hostvars['master']['ansible_host'] }}:27017'},{_id: 1, host:'{{ hostvars['slave1']['ansible_host'] }}:27017'},{_id: 2, host:'{{ hostvars['slave2']['ansible_host'] }}:27017'}]} 
;rs.initiate(config)"



