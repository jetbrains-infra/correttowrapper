FROM amazoncorretto:17.0.5

LABEL maintainer="Sergey Zhukov <sergey@jetbrains.com>" \
    maintainer="Sergey Kondrashov <sergey.kondrashov@jetbrains.com>"


ENV WRAPPER_VER 3.5.51
ENV WRAPPER_URL http://wrapper.tanukisoftware.com/download/${WRAPPER_VER}/wrapper-linux-x86-64-${WRAPPER_VER}.tar.gz

ADD wrapper.sed /

RUN mkdir -p /home/javaapp/standalone/{bin,conf,lib,logs,temp} /root/prerun; \
    yum install -y wget tar gzip initscripts && yum clean all && \
    wget -O /home/javaapp/wrapper-linux-x86-64-${WRAPPER_VER}.tar.gz ${WRAPPER_URL} && \
    cd /home/javaapp && \
    tar -xzf wrapper-linux-x86-64-${WRAPPER_VER}.tar.gz && \
    mv wrapper-linux-x86-64-${WRAPPER_VER} wrapper && \
    mv wrapper/bin/wrapper standalone/bin/ && \
    mv wrapper/conf/wrapper.conf standalone/conf/ && \
    mv wrapper/lib/libwrapper.so standalone/lib/ && \
    mv wrapper/lib/wrapper.jar standalone/lib/ && \
    sed -f /wrapper.sed < wrapper/src/bin/App.sh.in > /etc/init.d/javaapp && \
    chmod a+x /etc/init.d/javaapp && \
    rm /wrapper.sed && \
    rm -rf wrapper && \
    rm wrapper-linux-x86-64-${WRAPPER_VER}.tar.gz

# Adding cacerts file from current Java disto to "conf" directory of Tomcat
RUN cp /usr/lib/jvm/java-17-amazon-corretto/lib/security/cacerts /home/javaapp/standalone/conf/truststore
ADD onbuild /home/javaapp/onbuild/
ADD apply.sh /

# Apply additional transformations for configs
RUN bash -c ". /apply.sh"

# Apply additional transformations to children images
ONBUILD ADD onbuild /home/javaapp/onbuild/
ONBUILD RUN bash -c ". /apply.sh"

ADD run-javaapp.sh /

CMD /run-javaapp.sh

EXPOSE 8080
