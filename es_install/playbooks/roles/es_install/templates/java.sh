#!/bin/bash
if [ -d /usr/local/jdk ];
then
echo "jdk is install"
else
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
source /etc/profile