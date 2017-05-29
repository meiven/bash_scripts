#!/bin/bash

### VARIABLES

new=bak.jpg


### SCRIPT

for f in $( find -mindepth 2 -name "*.jpg" ); do

	echo $f

	convert -density 72 -quality 40 -strip $f $new

	sorig=$(stat -c%s $f)
	snew=$(stat -c%s $new)
	
	dif=$(( $sorig - $snew ))

	ratio=$(( $sorig / $snew))

	if [ $ratio -ge 1 ]; then

		if [ $ratio -lt 100 ]; then
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
