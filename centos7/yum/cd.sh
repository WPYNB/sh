#!/bin/bash

#新建光盘仓库
cat > /etc/yum.repos.d/cd.repo << EOF
[cd]
name=cd-rom
baseurl=file:///mnt/
gpgcheck=0
EOF

#挂载光盘
mount /dev/sr0 /mnt &> /etc/null

#安装autofs
yum install autofs -y &> /etc/null
#启动autofs
systemctl start autofs &> /etc/null
systemctl enable autofs &> /dev/null

#取消光盘挂载
umount /mnt

#重设仓库为自动挂载的光盘
cat > /etc/yum.repos.d/cd.repo << EOF
[cd]
name=cd-rom
baseurl=file:///misc/cd/
gpgcheck=1
gpgkey=file:///misc/cd/RPM-GPG-KEY-CentOS-7
EOF
