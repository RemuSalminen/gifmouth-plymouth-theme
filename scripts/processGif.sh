#!/usr/bin/env bash

BASEDIR="$( cd -- "$( dirname --  "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/.."

if [ -z "$1" ]; then
	echo "No GIF specified!"
	echo "Usage: $0 <path-to-GIF>"
	exit 1
fi

magick $1 "$BASEDIR/frames/frame.png"
