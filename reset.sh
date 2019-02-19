#!/bin/bash
. tools.sh

echo 'Please wait ...'

# 关闭firewall
firewall_close

# 关闭selinux
selinux_close

# 安装常用包
package_install

# 设置yum仓库
# ali - 阿里源
# tsinghua - 清华源
# cd - 本地光盘源
#yum_setcfg ali

# 设置网络
network_setcfg

echo 'Configuration completed.'
