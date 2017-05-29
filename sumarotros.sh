#!/bin/bash

### SCRIPT

total=0

for f in $( find -mindepth 2 -type f ! -name "*.js" ! -name "*.css" ! -name "*.mp4" ! -name "*.ogv" ! -name "*.mp3" ! -name "*.ogg" ! -name "*.jpg" ! -name "*.png" ! -name "*.html" ! -name "*.xml" ! -name "*.json" ! -name "*.pdf" ); do

	size=$(( $(stat -c%s $f) / 1000))
	

	echo $f - $size KB

	total=$((total+size))
	# $total = $(( $total + $size ))

done

echo -e "\nTamaño total de archivos $1: $total KB \n"
