FROM centos:centos7
ADD stgt.patch /tmp
RUN yum -y install gcc make patch && \
    curl -LO https://github.com/fujita/tgt/archive/v${tgtver:-1.0.62}.tar.gz && \
    tar xfz v${tgtver:-1.0.62}.tar.gz && \
    cd tgt-${tgtver:-1.0.62} && \
    patch -p1 < /tmp/stgt.patch && \
    rm -f /tmp/stgt.patch && \
    make install-programs && \
    cd - && \
    rm -rf v${tgtver:-1.0.62}.tar.gz v${tgtver:-1.0.62} && \
    yum remove -y $(awk '/Installed/{print $NF;}' /var/log/yum.log) && \
    yum clean all
EXPOSE 3260
ENTRYPOINT ["tgtd","-f"]
