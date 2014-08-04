#!/bin/bash
set -e

### What platform?
if grep "Linux Mint 14 Nadia" /etc/lsb-release >/dev/null 2>/dev/null; then
  platform=mint14
else
  platform=unknown
fi

### Create package name.
destname="openitg-$(git describe --dirty=-untracked)-$platform.zip"

### Ensure we are clean.
if git clean -nx | grep . >/dev/null 2>/dev/null; then
  echo "You should 'git clean' first."
  exit 1
fi

### Build!
if [ `uname -m` == x86_64 ]; then
  ./build-home-64.sh -j4
else
  ./build-home.sh -j4
fi

### Create the release zip.
./generate-home-release.sh
mv -f home-tmp.zip "$destname"
