#!/bin/sh

PROXY=http://10.0.0.1:8123

SOURCE=/source
BUILD_DIR=$SOURCE/build
FINAL_DIR=$SOURCE/final

PKG_USER=github.com/nizq
PKG_NAME=$PKG_USER/stenographer
STENO_DIR=$GOPATH/src/$PKG_NAME
STENOTYPE_DIR=${STENO_DIR}/stenotype

echo "===> Build testimony..."
cd $BUILD_DIR
if [ ! -d "testimony" ]; then
    git clone https://github.com/google/testimony.git
fi
cd testimony/c
make
cp -f -v libtestimony.a /usr/lib
cp -f -v libtestimony.so /usr/lib
cp -f -v libtestimony.so $FINAL_DIR/
cp -f -v testimony.h /usr/include

echo "===> Install golang/x/net/context..."
https_proxy=${PROXY} go get golang.org/x/net/context

echo "===> Install stenographer..."
CODE_BASE=$GOPATH/src/$PKG_USER
rm -rf $CODE_BASE
mkdir -p $CODE_BASE
cd $CODE_BASE
git clone https://${PKG_NAME}.git
cd $STENO_DIR
git checkout auth-ca-based
GOPATH=$BUILD_DIR/go go get github.com/nizq/stenographer

echo "===> Build stenotype manually..."
cd $STENOTYPE_DIR
make

echo "Collect files ..."
cp -f -v $GOPATH/bin/stenographer $FINAL_DIR/
cp -f -v $STENO_DIR/stenocurl $FINAL_DIR/
cp -f -v $STENO_DIR/stenoread $FINAL_DIR/
cp -f -v $STENOTYPE_DIR/stenotype $FINAL_DIR/
