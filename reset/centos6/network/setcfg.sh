#!/bin/bash

if=`ip a | sed -nr '/^2/,/^3/p' | grep -Eo '([[:digit:]]+\.){3}[[:digit:]]+/[[:digit:]]+' | head -1`
ip=`echo ${if%/*}`
mask=`echo ${if#*/}`

#添加网卡配置文件
cat > /etc/sysconfig/network-scripts/ifcfg-eth0 << EOF
DEVICE=eth0
TYPE=Ethernet
IPADDR=$ip
PREFIX=$mask
EOF
