#!/bin/bash

docker build -t nizq/steno-build .
docker run --rm -ti \
       -v `pwd`:/source \
       nizq/steno-build /source/build-steno.sh

cp Dockerfile.final final/Dockerfile
cp repositories final
cd final
docker build -t nizq/stenographer .
