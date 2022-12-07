#!/bin/bash
if [ -d /usr/local/jdk ];
then
echo "jdk is install"
else
tar xf {{ data_path }}/kafka/soft/jdk-8u202-linux-x64.tar.gz -C /usr/local
cd /usr/local
ln -s jdk1.8.0_202 jdk
cat >> /etc/profile << 'EOF'
export JAVA_HOME=/usr/local/jdk
export JAVA_BIN=/usr/local/jdk/bin
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
EOF
source /etc/profile
fi
cd {{ data_path }}/kafka/soft
tar xf apache-zookeeper-3.6.2-bin.tar.gz 
cp -rf apache-zookeeper-3.6.2-bin/* {{ data_path }}/zookeeper/

cd {{ data_path }}/zookeeper/conf/
mv zoo_sample.cfg zoo.cfg
mkdir {{ data_path }}/zookeeper/data
sed -i "s#/tmp/zookeeper#/data/zookeeper/data#" zoo.cfg
cat >> zoo.cfg <<EOF
server.1={{ hostvars['node1']['ansible_host'] }}:2888:3888
server.2={{ hostvars['node2']['ansible_host'] }}:2888:3888
server.3={{ hostvars['node3']['ansible_host'] }}:2888:3888
EOF
