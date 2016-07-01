FROM centos:centos7
RUN yum -y install gcc make && \
    curl -LO https://github.com/fujita/tgt/archive/v${tgtver:-1.0.65}.tar.gz && \
    tar xfz v${tgtver:-1.0.65}.tar.gz && \
    cd tgt-${tgtver:-1.0.65} && \
    make install-programs install-scripts && \
    cd - && \
    rm -rf v${tgtver:-1.0.65}.tar.gz v${tgtver:-1.0.65} && \
    yum remove -y $(awk '/Installed/{print $NF;}' /var/log/yum.log) && \
    yum -y install libiscsi libiscsi-utils && \
    yum clean all
EXPOSE 3260
ENTRYPOINT ["tgtd","-f"]
