#!/bin/bash
set -e
cd "$(dirname "$(readlink -f ${BASH_SOURCE[0]})")"

# Create links for data shared between versions.
ln -s ../Songs . || true
ln -s ../../MachineProfile Data/ || true

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
