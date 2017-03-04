#!/bin/bash
set -e
cd "$(dirname "$(readlink -f ${BASH_SOURCE[0]})")"
if [ ! -e Songs ]; then
    ln -s ../Songs .
fi
exec ./openitg "$@"
