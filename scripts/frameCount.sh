#!/usr/bin/env bash
find ../frames/ -type f -printf '%p\n' | grep -o -P "(?<=frame-).*(?=\.png)" | sort -nr | head -n 1
