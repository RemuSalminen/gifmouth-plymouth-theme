#!/usr/bin/env bash

match='0'
FRAMECOUNT=$(./frameCount.sh)
file='./customGif.script'

#sed "s/$match/$FRAMECOUNT/" $file
sed "1 i frameCount = $FRAMECOUNT;" $file
