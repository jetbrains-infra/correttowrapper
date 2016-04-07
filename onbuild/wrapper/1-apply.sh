#!/bin/bash

for CONF in `ls *.conf`
do
  cat ${CONF} >> /home/javaapp/standalone/conf/wrapper.conf
  rm ${CONF}
done

for CONF in `ls *.properties`
do
  cat ${CONF} >> /home/javaapp/standalone/conf/wrapper-additional.conf
  rm ${CONF}
done

