#!/bin/bash

. ver.sh

ver=$(ver)

#关闭firewall
firewall_close(){
        case $ver in
        centos7)
		. centos7/firewall/stop.sh
        esac
}

#关闭selinux
selinux_close(){
	case $ver in
	centos7|centos6)
		. centos/selinux/stop.sh
	esac
}

#安装常用包
package_install(){
	case $ver in
	centos7|centos6)
		. centos/rpm/rpm_install.sh
	esac
}

#设置yum仓库
yum_setcfg(){
	case $ver in
	centos7|centos6)
		. centos/yum/setcfg.sh $1
	esac
}

#设置网络
network_setcfg(){
	case $ver in
	centos7)
		. centos7/network/setcfg.sh
		;;
	centos6)
		. centos6/network/setcfg.sh
	esac
}
