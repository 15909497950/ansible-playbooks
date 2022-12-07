#!/bin/bash
su - app<<EOF
cd {{ data_path }}/soft;
tar xf mysql-5.7.32-linux-glibc2.12-x86_64.tar.gz;
cp -rf mysql-5.7.32-linux-glibc2.12-x86_64/* {{ data_path }};


sudo cp {{ data_path }}/support-files/mysql.server /etc/rc.d/init.d/mysqld;
sudo chmod 777 /etc/rc.d/init.d/mysqld;
sudo sed -i '46,47d' /etc/init.d/mysqld;
sudo sed -i '45a\basedir='{{ data_path }}'' /etc/init.d/mysqld;
sudo sed -i '46a\datadir='{{ data_path }}/data'' /etc/init.d/mysqld;
EOF
source /etc/profile


