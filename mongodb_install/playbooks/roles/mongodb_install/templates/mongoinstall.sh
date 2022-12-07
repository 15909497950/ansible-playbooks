#!/bin/bash



cd {{ data_path }}/soft
tar -xvf mongodb-linux-x86_64-rhel70-3.6.23.tgz 
cp -rf mongodb-linux-x86_64-rhel70-3.6.23/* {{ data_path }}/

cat >> /etc/profile << 'EOF'
export PATH=$PATH:{{ data_path }}/bin
EOF
source /etc/profile
mkdir -pv {{ data_path }}/{log,etc,data,pid}
openssl rand -base64 666 > {{ data_path }}/etc/keyfile
chmod 600 {{ data_path }}/etc/keyfile
