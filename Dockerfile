FROM debian:jessie

MAINTAINER nizq <ni.zhiqiang@gmail.com>

RUN echo "===> Adding dependency..." \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y g++ gcc git libaio-dev libcap2-bin libleveldb-dev libsnappy-dev libseccomp-dev make

ADD go1.5.2.linux-amd64.tar.gz /usr/local

ENV GOPATH=/source/build/go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

VOLUME ["/source"]
