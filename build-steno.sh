#!/bin/sh

BASE_DIR=/source
BUILD_DIR=$BASE_DIR/build
FINAL_DIR=$BASE_DIR/final

export GOPATH=${BUILD_DIR}/go
GO_SRC=$GOPATH/src
VENDORS=$BASE_DIR/vendors

STENO_USER_DIR=$GO_SRC/github.com/nizq
STENO_SRC_DIR=$STENO_USER_DIR/stenographer
STENOTYPE_SRC_DIR=$STENO_SRC_DIR/stenotype

rm -rf $BUILD_DIR/*

mkdir -p $GO_SRC/golang.org/x
ln -sf $VENDORS/net $GO_SRC/golang.org/x

mkdir -p $STENO_USER_DIR
ln -sf $VENDORS/stenographer $STENO_SRC_DIR

echo "===> Build testimony..."
ln -sf $VENDORS/testimony $BUILD_DIR
cd $BUILD_DIR/testimony/c
make
cp -f -v libtestimony.a /usr/lib
cp -f -v libtestimony.so /usr/lib
cp -f -v testimony.h /usr/include
cp -f -v libtestimony.so $FINAL_DIR/

echo "===> Install stenographer..."
go get github.com/nizq/stenographer

echo "===> Build stenotype manually..."
cd $STENOTYPE_SRC_DIR
sed -i "s/^SHARED_CFLAGS=-std=c++0x -g -Wall -fno-strict-aliasing/SHARED_CFLAGS=-std=c++0x -g -Wall -fno-strict-aliasing -D_GLIBCXX_USE_CXX11_ABI=0/g" Makefile
sed -i "s/-ltestimony$/-ltestimony -lexecinfo -largp/g" Makefile
make

echo "===> Collect files ..."
cp -f -v $GOPATH/bin/stenographer $FINAL_DIR/
cp -f -v $STENO_SRC_DIR/stenocurl $FINAL_DIR/
cp -f -v $STENO_SRC_DIR/stenoread $FINAL_DIR/
cp -f -v $STENOTYPE_SRC_DIR/stenotype $FINAL_DIR/
