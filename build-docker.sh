#!/bin/bash

GO_PKG=go1.5.2.linux-amd64.tar.gz

if [ ! -f $GO_PKG ]; then
    wget https://storage.googleapis.com/golang/$GO_PKG
fi

docker build -t nizq/steno-build .
docker run --rm -ti \
       --net host \
       -v `pwd`:/source \
       nizq/steno-build /source/build-steno.sh

cp Dockerfile.final final/Dockerfile
cd final
docker build -t nizq/stenographer .
