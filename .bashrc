#!/bin/bash

export DISPLAY=10.50.47.183:0.0
alias h=history

system=$(uname -a | awk '{print$6}')
echo " System - "$system

if [ "$system" == "sparc" ]
then
   export OS=SOL8
   export CPU=SUL
   export PATH=/home/imikhale/proj/SUNWspro/bin:/cgg/lv5000/bin:$PATH
   alias geos="cd /home/imikhale/proj/Geostore/make;ls;pwd"
   alias ram="cd /home/imikhale/proj/RAMv1.4.7_char/DISTR_RAM;ls;pwd"
else
   export OS=SOL10
   export CPU=SUL64
   export PATH=/opt/solstudio12.2/bin:/home/imikhale/proj/xemacs-21.4.22/src:$PATH
   alias ram="cd /home/imikhale/proj/RAMv1.4.7_SOL10/DISTR_RAM;ls;pwd"
fi


if [ "${TERM}"  == "screen" ]; then
    export PROMPT_COMMAND='echo -ne "\033k\033\0134\033k${USER}@${HOSTNAME} `echo ${PWD}`\033\0134"'
else

#    export PROMPT_COMMAND='echo -en "\033[0;32m"$(( `sed -n "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1048576))"\033[1;33m/"$((`sed -n "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1048576 )) GB" \033[0;32m `date +%H:%M:%S`"'     export PS1='\[\e[m\n\e[1;30m\]\[\e[1;30m\][\[\e[1;32m\]\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY}\e[1;30m\]] \[\e[1;37m\]\w \n(\!)% '
    export PROMPT_COMMAND='echo -en "\033[0;32m"$(( `sed -n "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1048576))"\033[1;33m/"$((`sed -n "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1048576 )) GB" \033[0;32m `date +%H:%M:%S`"'     export PS1='\[\e[m\n\e[1;30m\]\[\e[1;30m\][\[\e[1;32m\]\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY}\e[1;30m\]] \[\e[1;37m\]\w \n(\!) % '
fi


dmesg_with_human_timestamps () {
    $(type -P dmesg) "$@" | perl -w -e 'use strict;
        my ($uptime) = do { local @ARGV="/proc/uptime";<>}; ($uptime) = ($uptime =~ /^(\d+)\./);
        foreach my $line (<>) {
            printf( ($line=~/^\[\s*(\d+)\.\d+\](.+)/) ? ( "[%s]%s\n", scalar localtime(time - $uptime + $1), $2 ) : $line )
        }'
}
alias dmesg-date=dmesg_with_human_timestamps
