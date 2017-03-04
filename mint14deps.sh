#!/bin/bash
set -e
PACKAGES=(
git-core
make gcc g++
autoconf2.13
#automake1.9  # Causes problems if present.
gettext
libgl1-mesa-dev libglu1-mesa-dev
libpng12-dev libjpeg62-dev
liblua5.1-0-dev
libvorbis-dev libmad0-dev
libusb-dev
libxrandr-dev
libavcodec-dev
libavformat-dev
libswscale-dev
libasound2-dev
libresample1-dev
libcrypto++-dev
libgtk2.0-dev
libsdl1.2-dev
)
sudo apt-get install "${PACKAGES[@]}"
