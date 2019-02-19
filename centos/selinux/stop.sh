#!/bin/bash

#关闭selinux
setenforce 0 &> /dev/null
sed -i '/^SELINUX=enforcing/s/enforcing/disabled/' /etc/selinux/config
