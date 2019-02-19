#!/bin/bash

#备份仓库
mkdir /etc/yum.repos.d/bak &> /dev/null
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak

#设置仓库为自动挂载的光盘
cat > /etc/yum.repos.d/custom.repo << EOF
[cd]
name=cd-rom
baseurl=file:///misc/cd/
gpgcheck=1
gpgkey=file:///misc/cd/RPM-GPG-KEY-CentOS-6
EOF
