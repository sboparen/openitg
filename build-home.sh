#!/bin/bash

./autogen.sh
if grep "Linux Mint 14 Nadia" /etc/lsb-release >/dev/null 2>/dev/null; then
    ./configure --with-x --with-gnu-ld --with-legacy-ffmpeg
else
    ./configure --with-x --with-gnu-ld
fi
make clean
if [ "x$1" = "x" ];
then
    echo "Running make"
    make
else
    echo "Running make -j$1"
    make -j$1
fi

strip --strip-unneeded --remove-section=.note.gnu.build-id src/openitg
