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

if (./scripts/processGif.sh "$1"); then
	echo "Succesfully Processed GIF!"
else
	echo "Could Not Process GIF"!
	exit 1
fi

if (./scripts/createScript.sh); then
	echo "Succesfully Created Script File!"
else
	echo "Could Not Create Script File!"
	exit 1
fi

echo "Theme Created Succesfully!"
