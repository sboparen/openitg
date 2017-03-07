#!/bin/bash

source common.sh

has_command "zip" "zip command not found"
has_file "src/openitg" "where's the openitg binary?"

build_version=`git describe --abbrev=0`
build_rev_tag=`git describe`
if test "$build_version" != "$build_rev_tag"; then
    build_version="${build_version}DEV"
fi
platform=unknown
if grep "Linux Mint 14 Nadia" /etc/lsb-release >/dev/null 2>/dev/null; then
    platform=mint14
fi
NAME="openitg-$build_version-$platform"

rm -f "$NAME.zip"

HOME_TMP_DIR=/tmp/openitg-home-tmp/$NAME

rm -rf /tmp/openitg-home-tmp
mkdir -p $HOME_TMP_DIR

# Copy game content
cp -r assets/d4/* $HOME_TMP_DIR
cp -r assets/game-data/* $HOME_TMP_DIR

# Copy patch content
# mkdir -p $HOME_TMP_DIR/Data/patch/patch
# cp -r assets/patch-data/* $HOME_TMP_DIR/Data/patch/patch
# This overwrites files from d4 and game-data where patch-data have newer files.
# Having a patch.zip in the home release has no benefits and only complicates things.
cp -r assets/patch-data/* $HOME_TMP_DIR

# Remove useless files
rm -f $HOME_TMP_DIR/zip.sh
rm -rf $HOME_TMP_DIR/Cache
rm -rf $HOME_TMP_DIR/Songs
rm -rf $HOME_TMP_DIR/Themes/ps2onpc
rm -rf $HOME_TMP_DIR/Themes/ps2
rm -rf $HOME_TMP_DIR/Data/patch/patch/Cache
rm -rf $HOME_TMP_DIR/Data/patch/patch/Songs

cp {ReleaseNotes.txt,WhoToSue.txt} $HOME_TMP_DIR/
cp src/{openitg,GtkModule.so} $HOME_TMP_DIR/

CWD=`pwd`
#(cd $HOME_TMP_DIR && zip -u -r $CWD/home-tmp.zip *)
(
    set -e
    ts="$(git log -1 --pretty="format:%ad" --date=format:"%Y%m%d%H%M")"
    cd /tmp/openitg-home-tmp
    find . -print0 | xargs -0 touch -t "$ts"
    find . | sort | xargs -d '\n' zip -X "$CWD/$NAME.zip"
)

rm -rf /tmp/openitg-home-tmp
