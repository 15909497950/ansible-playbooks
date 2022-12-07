#!/bin/bash

cd {{ data_path }}/soft
yum -y install libnl libnl-devel openssl-devel


tar xf keepalived-2.0.20.tar.gz
cd keepalived-2.0.20
./configure --prefix={{ data_path }}
make && make install

sudo mkdir /etc/keepalived

cp {{ data_path }}/soft/keepalived-2.0.20/keepalived/etc/init.d/keepalived /etc/init.d/keepalived


