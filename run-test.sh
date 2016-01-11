#!/bin/bash

docker run --ulimit memlock=2147483648:2147483648 -it --rm -v `pwd`/test/conf:/etc/stenographer -v ``/test/certs:/certs -v `pwd`/test/data:/data --net host nizq/steno-alpine stenographer -syslog=false
