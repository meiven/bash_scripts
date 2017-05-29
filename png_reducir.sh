#!/bin/bash

### VARIABLES

new=bak.png


### SCRIPT

for f in $( find -mindepth 2 -name "*.png" -size +200k ); do

	convert -resize '1024x1024>' $f $new

	sorig=$(stat -c%s $f)
	snew=$(stat -c%s $new)

	ratio=$(( $sorig / $snew))

	if [ $ratio -ge 1 ]; then

		if [ $ratio -lt 5 ]; then
			rm -f $f
			mv $new $f
			echo $(($sorig / 1000)) "KB -->" $(($snew / 1000)) "KB"
		else 
			echo "demasiado! ("$(($sorig / 1000)) "KB -->" $(($snew / 1000))") KB"
			rm -f $new
		fi
	else 
		rm -f $new
		echo "sin reduccion"
	fi

done
