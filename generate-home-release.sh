#!/bin/sh
set -e

rm -f home-tmp.zip
if [ "`which zip`x" = "x" ]; then
	echo "$0: zip command not found"
	exit
fi
if [ ! -f src/openitg ]; then
	echo "$0: where's the openitg binary?"
fi
(cd assets/d4 && zip -u -r ../../home-tmp.zip *)

# remove useless files
zip -d home-tmp.zip 'Themes/ps2onpc/*'
zip -d home-tmp.zip 'Themes/ps2/*'

(cd assets/game-data && zip -r ../../home-tmp.zip *)
(cd assets/patch-data && zip -r ../../home-tmp.zip Data NoteSkins Themes)
zip -d home-tmp.zip 'Cache/*' || true
zip home-tmp.zip FAQ.txt ReleaseNotes.txt WhoToSue.txt
(cd src && zip ../home-tmp.zip openitg GtkModule.so)
