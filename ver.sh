#!/bin/bash

#判断系统版本
ver(){
#centos系列
if [ -f '/etc/centos-release' ];then
        #获取版本号
        ver=`grep -Eo '[[:digit:].]+' /etc/centos-release`
        #获取主版本号
        ver_major=${ver:0:1}
        #centos7
        case $ver_major in
        7)
                echo 'centos7'
                ;;
        6)
                echo 'centos6'
        esac
fi
}
