#!/usr/bin/env bash

if [ -z "$1" ]; then
	echo "No GIF Provided!"
	echo "Usage: $0 <path-to-GIF>"
	exit 1
fi

if (rm ./frames/*.png); then
	echo "Succesfully Removed Old Frames!"
else
	echo "Could Not Remove Old Frames!"
	exit 1
fi

## Process GIF
magick $1 "./frames/frame.png"

## Create Script
FRAMECOUNT=find ./frames/ -type f -printf '%p\n' | grep -o -P "(?<=frame-).*(?=\.png)" | sort -nr | head -n 1
TEMPLATE="./scripts/customGif.script.template"
SCRIPTNAME='customGif.script'

sed "1 i frameCount = $FRAMECOUNT;" $TEMPLATE > ./scripts/$SCRIPTNAME

echo "Theme Created Succesfully!"
