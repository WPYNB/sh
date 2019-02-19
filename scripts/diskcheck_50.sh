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
waring=80
disk=`df | grep "/dev/sd" |  tr -s " " "%" | cut -d% -f5 | sort -rn | head -1`
[ $disk -gt $waring ] &&  wall disk will be full || wall  ok