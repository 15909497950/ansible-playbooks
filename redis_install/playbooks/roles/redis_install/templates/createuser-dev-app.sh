#!/bin/bash
username=app
username1=devops
echo $username
echo $username1
count=`cat /etc/passwd | grep -w ${username} -c`
count1=`cat /etc/passwd | grep -w ${username1} -c`
echo $count
echo $count1
passwd="2k3Abv/GPhqvKz+usduN+msZQk0=i"
passwd1="v7cHT6tXkttZxlHC/KSC9Vdo+H4="
echo ${passwd}
echo ${passwd1}

if [[ $count -lt 1 ]] && [[ $count1 -lt 1 ]]
then
  useradd $username
  useradd $username1
  echo ${passwd} | passwd $username --stdin
  echo ${passwd1} | passwd $username1 --stdin
  echo "你已完成${username} ${username1}用户新建"
  sed -i '100 a\app    ALL=(ALL)      NOPASSWD: ALL' /etc/sudoers
  else
  echo "用户已存在"
fi
