FROM centos:centos7
RUN yum -y install gcc make patch && \
    curl -LO https://github.com/fujita/tgt/archive/v${tgtver:-1.0.63}.tar.gz && \
    tar xfz v${tgtver:-1.0.63}.tar.gz && \
    cd tgt-${tgtver:-1.0.63} && \
    make install-programs install-scripts && \
    cd - && \
    rm -rf v${tgtver:-1.0.63}.tar.gz v${tgtver:-1.0.63} && \
    yum remove -y $(awk '/Installed/{print $NF;}' /var/log/yum.log) && \
    yum -y install libiscsi libiscsi-utils && \
    yum clean all
EXPOSE 3260
ENTRYPOINT ["tgtd","-f"]
