#!/usr/bin/env bash

if [ -z "$1" ]; then
	echo "No GIF Provided!"
	echo "Usage: $0 <path-to-GIF>"
	exit 1
fi

./scripts/processGif.sh "$1"

./scripts/createScript.sh

echo "Theme Created Succesfully!"
