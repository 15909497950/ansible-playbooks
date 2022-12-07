#/bin/bash
function check_tools() {
  echo "开始检测运行信息是否符合要求"
  #检测是否安装了mongosh client工具
  mongosh --help >/dev/null 2>&1
  retCode=$?
  if [[ $retCode -ne 0 ]]; then
    mongo_path={{ data_path }}/soft
    cd $mongo_path
    if [ ! -f $mongo_path/mongodb-mongosh-1.0.5.el7.x86_64.rpm ]; then
      echo "安装mongosh 失败，mongodb-mongosh-1.0.5.el7.x86_64.rpm 部署包不存在。"
      exit 1
    fi
    rpm -ivh $mongo_path/mongodb-mongosh-1.0.5.el7.x86_64.rpm  --nodeps --force
    mongosh --help >/dev/null 2>&1
    retCode=$?
    if [[ $retCode -ne 0 ]]; then
      error "安装mongosh 失败。"
      exit 1
    fi
  fi
}

function account(){
 int=1
 masterip=""
 sleep 10s
 while (( $int <= 30  ))
 do 
 sleep 1s
 masterip=`echo 'rs.hello()' |{{ data_path }}/bin/mongo --host {{ hostvars['master']['ansible_host'] }} --port 27017 | grep primary | awk -F '"' '{print $4}' |awk -F ':' '{print $1}'`
 if [ "$masterip" != "" ]
 then
   break
 fi
   let "int++"
 done
 echo "masterip:"$masterip >/data/mongodb/shell/account.log 
 mongosh  --host ${masterip} --port 27017 --norc  <{{ data_path }}/shell/account.js  >>/data/mongodb/shell/account.log
}

check_tools
account
sleep 5s
