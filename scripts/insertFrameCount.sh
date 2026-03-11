#!/usr/bin/env bash

FRAMECOUNT=$(./frameCount.sh)
TEMPLATE='./customGif.script.template'
SCRIPTNAME='customGif.script'

sed "1 i frameCount = $FRAMECOUNT;" $TEMPLATE > $SCRIPTNAME
