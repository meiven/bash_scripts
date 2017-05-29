#!/bin/bash

### SCRIPT

total=0

for f in $( find -mindepth 2 -name "*.png" -size +100k ); do

	size=$(( $(stat -c%s $f) / 1000))
	

	echo $f - $size KB

	total=$((total+size))
	# $total = $(( $total + $size ))

done

echo -e "\nTamaño total de archivos $1: $total KB \n"
