#!/bin/bash
#
# $1 - path to truststore
#

for cafile in `ls *.pem`
do
  caalias=`echo ${cafile} |  sed s/\.[^\.]*$//`
  /usr/lib/jvm/java-21-amazon-corretto/bin/keytool -import -file /home/javaapp/onbuild/cacerts/$cafile -alias $caalias -keystore $1 -storepass changeit -noprompt -trustcacerts
  rm ${cafile}
done
