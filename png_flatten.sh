#!/bin/bash

### VARIABLES

new=bak.png


### SCRIPT

for f in $( find -name "*.png" -size +200k ); do

	echo $f

	convert -flatten $f $new

	sorig=$(stat -c%s $f)
	snew=$(stat -c%s $new)

	ratio=$(( $sorig / $snew))

	echo $(($sorig / 1000)) "KB -->" $(($snew / 1000)) "KB"

	rm -f $f
	mv $new $f

done
