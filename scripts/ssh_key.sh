#!/bin/bash
#
#********************************************************************
#Author:		WeiPingYang
#QQ: 			812756780
#Date: 			2018-11-15
#FileName：		ssh_key.sh
#URL: 			http://wpynb.github.io
#Description：		The test script
#Copyright (C): 	2018 All rights reserved
#********************************************************************
user=wpy
password=123456
ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa 
while read ip ;do
expect <<EOF
set timeout 10
spawn ssh-copy-id -i /root/.ssh/id_rsa.pub $user@$ip
expect {
"yes/no" { send "yes/no";exp_continue }
"password" { send "$password\n" }
}
expect eof
EOF
done < /data/iplist.txt

#需准备iplist.txt文件并安装expect