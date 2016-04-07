#!/bin/bash

# Apply additional transformations for configs
cd /home/javaapp/onbuild/wrapper/ && . ./1-apply.sh /home/javaapp/standalone && \
cd /home/javaapp/onbuild/cacerts/ && . ./1-apply.sh /home/javaapp/standalone/conf/truststore
