#!/bin/bash

lim=900

for f in $( find -mindepth 1 -name "*.png" -size +100k ); do

	ancho=$(identify -format "%w" $f)
	alto=$(identify -format "%h" $f)

	if [ $ancho -gt $lim ]; then
		echo "ancho: " $ancho $f
	fi

	if [ $alto -gt $lim ]; then
		echo "alto: " $alto $f
	fi

done

