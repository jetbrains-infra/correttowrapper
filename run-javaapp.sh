#!/bin/sh

if [[ -f /pre-run.sh ]] ; then
    . /pre-run.sh
fi

for prerun in `ls /root/prerun/*.sh`
do
    . ${prerun}
done

trap "/usr/sbin/service javaapp stop" SIGINT SIGTERM SIGHUP

/usr/sbin/service javaapp console &

wait
