#!/bin/bash
set -e
cd "$(dirname ${BASH_SOURCE[0]})"
CELPATH=../../../d4/NoteSkins/dance/cel/
test -e $CELPATH
rm -rf couples
cp -r $CELPATH couples
for src in couples/Down*Hold*.png; do
    mogrify -fill orange -tint 100 "$src"
    convert "$src" -strip -define png:exclude-chunks=date,time "$src"
done
for src in couples/*Down*Roll*.png; do
    mogrify -fill 'rgb(40,0,255)' -tint 200 "$src"
    convert "$src" -strip -define png:exclude-chunks=date,time "$src"
done
