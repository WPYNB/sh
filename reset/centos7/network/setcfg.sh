#!/bin/bash

if=`ip a | sed -nr '/^2/,/^3/p' | grep -Eo '([[:digit:]]+\.){3}[[:digit:]]+/[[:digit:]]+' | head -1`
ip=`echo ${if%/*}`
mask=`echo ${if#*/}`
gateway=`route -n | awk '$1 ~ /0.0.0.0/ {print $2}'`

#添加网卡配置文件
cat > /etc/sysconfig/network-scripts/ifcfg-eth0 << EOF
DEVICE=eth0
TYPE=Ethernet
IPADDR=$ip
PREFIX=$mask
GATEWAY=$gateway
DNS1=$gateway
EOF

#关闭“一致性网络设备命名法”
sed -i -r '/^GRUB_CMDLINE_LINUX=/s/"$/ net.ifnames=0 biosdevname=0"/' /etc/default/grub

#更新GRUB、内核配置
grub2-mkconfig -o /boot/grub2/grub.cfg &> /dev/null

echo 'NOTE: Need to restart the computer for the configuration to take effect.'
