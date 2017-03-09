#!/bin/sh
if [ ! -d musl-cross-make/stage1 ]; then
    cd musl-cross-make
    cp stage1.mak config.mak
    make all install
    make clean
fi
if [ ! -d musl-cross-make/stage2 ]; then
    cd musl-cross-make
    cp stage2.mak config.mak
    export PATH="$PWD/stage1/bin:$PATH"
    make all install
    make clean
    #rm musl-cross-make/stage2
    #rm musl-cross-make/stage2/x86_64-linux-musl/lib/*.so.*
fi
#if [ ! -f config.mk ]; then
#    echo 'export PATH := $(PWD)/musl-cross-make/stage2/bin:$(PATH)' >> config.mk
#    echo 'CC = x86_64-linux-musl-gcc' >> config.mk
#    echo 'LD = $(CC)' >> config.mk
#    echo 'AR = x86_64-linux-musl-ar' >> config.mk
#fi
