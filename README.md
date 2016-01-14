# docker-stenographer

```
git clone --recursive https://github.com/nizq/docker-stenographer.git
cd docker-stenographer
./build-docker.sh
```

[Generate self signed sertificates](https://github.com/coreos/docs/blob/master/os/generate-self-signed-certificates.md) use cfssl/cfssljson. 

```
docker run --ulimit memlock=2147483648:2147483648 -it --rm -v `pwd`/test/conf:/etc/stenographer -v ``/test/certs:/certs -v `pwd`/test/data:/data --net host nizq/steno-alpine stenographer -syslog=false
```

Stenographer needs 2G memlock at least.
