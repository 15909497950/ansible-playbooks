#!/bin/bash

cd {{ data_path }}/glusterfs-9.2/rpm/client
tar zxvf glusterfs-client.tar.gz
yum localinstall  *.rpm -y

