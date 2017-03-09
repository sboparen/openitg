#!/bin/bash

./autogen.sh
./configure --with-x --with-gnu-ld
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
