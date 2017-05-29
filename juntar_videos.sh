#!/bin/bash

> listavideos

for f in $( find -name "*.mp4" | sort ); do

	video=$(basename $f)

	echo "file '"$video"'" >> listavideos

done

ffmpeg -f concat -i listavideos -c copy output.mp4