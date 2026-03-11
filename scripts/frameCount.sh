#!/usr/bin/env bash

BASEDIR="$( cd -- "$( dirname --  "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/.."

find "$BASEDIR/frames/" -type f -printf '%p\n' | grep -o -P "(?<=frame-).*(?=\.png)" | sort -nr | head -n 1
