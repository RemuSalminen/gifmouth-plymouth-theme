#!/usr/bin/env sh

if [ -z "$1" ]; then
	echo "No GIF Provided!"
	echo "Usage: $0 <path-to-GIF>"
	exit 1
fi

rm -f ./frames/*.png
rm -f ./scripts/gifmouth.script

set -e

## Process GIF
magick $1 -coalesce "./frames/frame.png"

## Create Script
FRAMECOUNT=$(find ./frames -type f -printf '%p\n' | grep -o -P "(?<=frame-).*(?=\.png)" | sort -nr | head -n 1)
TEMPLATE="./scripts/gifmouth.script.template"
SCRIPTNAME='gifmouth.script'

sed "1 i frameCount = $FRAMECOUNT;" $TEMPLATE > ./scripts/$SCRIPTNAME

echo "Theme Created Succesfully!"
