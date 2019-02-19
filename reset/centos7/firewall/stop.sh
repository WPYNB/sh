#!/bin/bash

#关闭firewall
systemctl stop firewalld
systemctl disable firewalld &> /dev/null
