#!/bin/bash
echo "系统内核参数优化！"
echo never > /sys/kernel/mm/transparent_hugepage/enabled


yum -y install zlib-devel openssl-devel gcc-c++
echo "redis编译安装！"
cd {{ data_path }}/soft
tar xf redis-5.0.9.tar.gz
cd redis-5.0.9
make PREFIX={{ data_path }} install
chown -R app:app {{ data_path }}
cat > /etc/profile.d/redis.sh <<EOF
PATH={{ data_path }}/bin:\$PATH
export PATH
EOF
source /etc/profile.d/redis.sh

