FROM alpine:3.3

ADD repositories /etc/apk/
RUN set -ex \
    && apk add --update bash ca-certificates gcc musl-dev   \
                        go openssl git linux-headers g++ make  \
                        libexecinfo-dev leveldb-dev libaio-dev \
                        libseccomp-dev argp-standalone snappy-dev

VOLUME ["/source"]
