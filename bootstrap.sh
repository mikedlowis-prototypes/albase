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
fi
