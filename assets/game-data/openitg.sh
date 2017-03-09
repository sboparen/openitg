#!/bin/bash
set -e
cd "$(dirname "$(readlink -f ${BASH_SOURCE[0]})")"

# Create link for the Songs folder.
ln -s ../Songs . || true

# If Data/MachineProfile isn't a directory then it seems to use
# ~/.openitg/Data/MachineProfile instead, which I think is better.
touch Data/MachineProfile

# Create or update launcher on desktop.
cat >~/Desktop/OpenITG.desktop <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Exec=$PWD/openitg.sh
Name=OpenITG
Icon=$PWD/icon.png
EOF
chmod +x ~/Desktop/OpenITG.desktop

# Start OpenITG.
exec ./openitg "$@"
