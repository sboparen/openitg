#!/bin/bash
set -e
./autogen.sh
./configure --with-x --with-gnu-ld
make "$@"
