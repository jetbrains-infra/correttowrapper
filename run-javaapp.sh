#!/bin/sh

if [[ -f /pre-run.sh ]] ; then
    . /pre-run.sh
fi

for prerun in `ls /root/prerun/*.sh`
do
    . ${prerun}
done

trap "/sbin/service javaapp stop" SIGINT SIGTERM SIGHUP

/sbin/service javaapp console &

wait

