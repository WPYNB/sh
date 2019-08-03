#!/bin/bash
cat << EOF
+---------------------------------------------------------------------------+
|  Initialize for the CentOS installed.                                   |
+---------------------------------------------------------------------------+
EOF
 
function format() {
    #sleep 1
    #echo -e "\033[42;37m ########### Finished ########### \033[0m\n"
    echo -e "\033[1;5;32m -_- Success!!!\033[0m\n"
}

########禁用防火墙和SElinux######
echo -e "\033[1;32m Disabled SELinux \033[0m\n"
sleep 1
sed -i 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
format

echo -e "\033[1;32m Stop iptables \033[0m\n"
sleep 1
service iptables stop &> /dev/null
format 

######配置yum仓库##########
echo -e "\033[1;32m 配置yum仓库 \033[0m\n"
cd /etc/yum.repos.d/
mkdir bak
mv *.repo bak/
cat >centos-base.repo<<EOF
[base]
name=CentOS-\$releasever - Base - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/os/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/os/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/os/\$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-6
 
[epel]
name=CentOS-\$releasever - epel - mirrors.aliyun.com
baseurl=https://mirrors.aliyun.com/epel/\$releasever/\$basearch/
gpgcheck=0

#released updates 
[updates]
name=CentOS-\$releasever - Updates - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/updates/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/updates/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/updates/\$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-6
 
#additional packages that may be useful
[extras]
name=CentOS-\$releasever - Extras - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/extras/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/extras/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/extras/\$basearch/
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-6
 
#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-\$releasever - Plus - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/centosplus/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/centosplus/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/centosplus/\$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-6
 
#contrib - packages by Centos Users
[contrib]
name=CentOS-\$releasever - Contrib - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos/\$releasever/contrib/\$basearch/
        http://mirrors.aliyuncs.com/centos/\$releasever/contrib/\$basearch/
        http://mirrors.cloud.aliyuncs.com/centos/\$releasever/contrib/\$basearch/
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-6
EOF
yum clean all &> /dev/null
yum makecache &> /dev/null
sleep 1
format

########同步时间###########
echo -e "\033[1;32m Set time \033[0m\n"
sleep 1
/bin/cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime &> /dev/null
yum -y install ntpdate &> /dev/null
ntpdate  0.centos.pool.ntp.org &> /dev/null
hwclock -w
format

######设置ssh登陆策略#######
echo -e "\033[1;32m Set sshd \033[0m\n"
sleep 1
sed -i "s/^#PermitEmptyPasswords/PermitEmptyPasswords/" /etc/ssh/sshd_config
sed -i "s/^#LoginGraceTime 2m/LoginGraceTime 6m/" /etc/ssh/sshd_config
 
grep "UseDNS no" /etc/ssh/sshd_config &>/dev/null
if [ $? -ne 0 ]
then
    echo "UseDNS no" >> /etc/ssh/sshd_config
fi
format
