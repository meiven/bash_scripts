#!/bin/bash

### VARIABLES

new=bak.png


### SCRIPT

echo "Reduciendo densidad, calidad, colores, profundidad y tamaño:"

> log_pngs_demasiado

for f in $( find -mindepth 2 -name "*.png" -size +500k ); do

	echo $f 

	convert -flatten $f $new
	rm -f $f
	mv $new $f

	convert -density 72 -quality 75 -colors 255 -depth 8 -resize '900x900>' -strip $f $new

	sorig=$(stat -c%s $f)
	snew=$(stat -c%s $new)

	ratio=$(( $sorig / $snew))

	if [ $ratio -ge 1 ]; then

		if [ $ratio -lt 4 ]; then
			rm -f $f
			mv $new $f
			echo $(($sorig / 1000)) "KB -->" $(($snew / 1000)) "KB"
		else 
			echo "demasiado! ("$(($sorig / 1000)) "KB -->" $(($snew / 1000))") KB"
			echo $f >> log_pngs_demasiado
			rm -f $new
		fi
	else 
		rm -f $new
		echo "sin reduccion"
	fi

done
