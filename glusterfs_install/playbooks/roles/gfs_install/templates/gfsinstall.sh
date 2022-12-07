#!/bin/bash



su - app<<EOF
cd {{ data_path }};
tar zxvf glusterfs-9.2.tar.gz;
cd glusterfs-9.2;
tar zxvf glusterfs.tar.gz;
cd {{ data_path }}/glusterfs-9.2/rpm/server;
sudo yum localinstall  *.rpm -y;
sudo mkdir /opt/glusterd;
sudo sed -i 's#var/lib#opt#g' /etc/glusterfs/glusterd.vol;
sudo systemctl start glusterd.service;
sudo systemctl enable glusterd.service;
#systemctl status glusterd.service
EOF
chown -R app:app /data