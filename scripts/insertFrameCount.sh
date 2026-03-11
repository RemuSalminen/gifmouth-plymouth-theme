#!/usr/bin/env bash

FRAMECOUNT=$(./frameCount.sh)
file='./customGif.script'

sed "1 i frameCount = $FRAMECOUNT;" $file
