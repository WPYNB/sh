#!/bin/bash

. ver.sh

ver=$(ver)
path=$(pwd)/$ver

#备份仓库
mkdir /etc/yum.repos.d/bak
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/bak

#设置为本地cd光盘仓库
if [ $1 == cd ];then
    . $path/cd.sh
    return
fi

#设置源
cp $path/yum/$1/*.repo /etc/yum.repos.d/
