#!/bin/bash
cd {{ data_path }}/kafka/soft
tar xf kafka_2.13-2.6.0.tgz
cp -rf kafka_2.13-2.6.0/* {{ data_path }}/kafka/

cd {{ data_path }}/kafka
sed -i -c -e '/^$/d;/^#/d' config/server.properties
sed -i "s#log.dirs=/tmp/kafka-logs#log.dirs=/data/kafka/logs#" config/server.properties
sed -i "s/zookeeper.connect=localhost:2181/zookeeper.connect={{ hostvars['node1']['ansible_host'] }}:2181,{{ hostvars['node2']['ansible_host'] }}:2181,{{ hostvars['node3']['ansible_host'] }}:2181/g" config/server.properties
cat >> config/server.properties <<EOF
listeners=PLAINTEXT://{{ ansible_host }}:9092
advertised.listeners=PLAINTEXT://{{ ansible_host }}:9092
EOF

source /etc/profile
