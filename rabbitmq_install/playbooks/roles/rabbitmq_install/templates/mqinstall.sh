#!/bin/bash
yum install -y make gcc gcc-c++ m4 openssl openssl-devel ncurses-devel unixODBC unixODBC-devel perl
if [ -d /usr/local/jdk ];
then
echo "jdk is install"
else
tar xf {{ data_path }}/soft/jdk-8u202-linux-x64.tar.gz -C /usr/local
cd /usr/local
ln -s jdk1.8.0_202 jdk
cat >> /etc/profile << 'EOF'
export JAVA_HOME=/usr/local/jdk
export JAVA_BIN=/usr/local/jdk/bin
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
EOF
fi
source /etc/profile

cd {{ data_path }}/soft


tar -zxvf {{ data_path }}/soft/otp_src_21.1.tar.gz
mkdir -p /usr/local/erlang
cd {{ data_path }}/soft/otp_src_21.1
./configure --prefix=/usr/local/erlang
num=`lscpu|grep "^CPU(s)" |awk '{print $2}'`
make -j$num && make install

cat >> /etc/profile << 'EOF'
export PATH=$PATH:/usr/local/erlang/bin
EOF
source /etc/profile

cd {{ data_path }}/soft
tar -xf rabbitmq-server-generic-unix-3.7.8.tar.xz

cp -rf rabbitmq_server-3.7.8/* {{ data_path }}
cat >> /etc/profile << 'EOF'
export PATH=$PATH:{{ data_path }}/sbin
EOF
source /etc/profile
chown -R app:app {{ data_path }}
chown -R app:app /usr/local/erlang
