#!/bin/bash

docker build -t nizq/steno-build-alpine .
docker run --rm -ti \
       -v `pwd`:/source \
       nizq/steno-build-alpine /source/build-steno.sh

cp Dockerfile.final final/Dockerfile
cp repositories final
cd final
docker build -t nizq/steno:alpine .
