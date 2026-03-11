#!/usr/bin/env bash

if [ -z "$1" ]; then
	echo "No GIF specified!"
	echo "Usage: $0 <path-to-GIF>"
	exit 1
fi

magick $1 ../frames/frame.png
