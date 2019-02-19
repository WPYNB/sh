#!/bin/bash
#
#********************************************************************
#Author:                weipingyang
#QQ:                    812756780
#Date:                  2018-10-10
#FileName：             diskcheck_50.sh
#Description：          The test script
#Copyright (C):         2018 All rights reserved
#********************************************************************
disk=`df | egrep "/dev/sd[a-z]" |  tr -s " " "%" | cut -d% -f5 | sort -rn | head -1`
echo $disk
[ $disk -gt 80 ] &&  wall  sajhl || wall  ok
