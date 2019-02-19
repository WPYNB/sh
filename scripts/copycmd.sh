#!/bin/bash



 
ch_root="/mnt/sysroot"
[ ! -d $ch_root ] && mkdir $ch_root
 
bincopy() {
    if which $1 &>/dev/null; then

        local cmd_path=`which --skip-alias $1`
        local bin_dir=`dirname $cmd_path`
        [ -d ${ch_root}${bin_dir} ] || mkdir -p ${ch_root}${bin_dir}
        [ -f ${ch_root}${cmd_path} ] || cp $cmd_path ${ch_root}${bin_dir}
        return 0
    else
        echo "Command not found."
        return 1
    fi
}
 
libcopy() {
    local lib_list=$(ldd `which --skip-alias $1` | grep -Eo '/[^[:space:]]+')
    for loop in $lib_list;do
        local lib_dir=`dirname $loop`
        [ -d ${ch_root}${lib_dir} ] || mkdir -p  ${ch_root}${lib_dir}
        [ -f ${ch_root}${loop} ] || cp $loop ${ch_root}${lib_dir}
    done
}
 
 
read -p "Please input a command: " command
 
while [ "$command" != "quit" ];do
    if bincopy $command ;then
        libcopy $command
    fi
    read -p "Please input a command or quit: " command
done
