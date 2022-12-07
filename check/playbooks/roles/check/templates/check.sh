#!/bin/bash
username=app
username1=devops
echo $username
echo $username1
count=`cat /etc/passwd | grep -w ${username} -c`
count1=`cat /etc/passwd | grep -w ${username1} -c`
echo $count
echo $count1

if [ -d /data ];then
chown -R app:app /data
else
mkdir /data
chown -R app:app /data
fi


if [[ $count -lt 1 ]] && [[ $count1 -lt 1 ]]
then
  useradd $username
  useradd $username1
  echo "{{ passwd }}" | passwd $username --stdin
  echo "{{ dev_passwd }}" | passwd $username1 --stdin
  echo "你已完成${username} ${username1}用户新建"
  
  else
  echo "用户已存在"
fi
id=`sed -n '/app    ALL=(ALL)/p' /etc/sudoers|wc -l`
if [ $id == 0 ];
then
  sed -i '100 a\app    ALL=(ALL)      NOPASSWD: ALL' /etc/sudoers
  else
  echo "app sudo is ok"
fi