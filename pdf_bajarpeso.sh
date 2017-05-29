#!/bin/bash


### SCRIPT

for f in $( find -mindepth 2 -name "*.pdf" -size +200k); do

    cp $f bak.pdf

	mogrify -density 180 -quality 60 -compress jpeg bak.pdf

	sorig=$(stat -c%s $f)
	snew=$(stat -c%s bak.pdf)
	
	dif=$(( $sorig - $snew ))

	if [ $dif -gt 0 ]; then
		rm -f $f
		mv bak.pdf $f
		echo $f ":" $(($sorig / 1000)) "KB -->" $(($snew / 1000)) "KB"
	else
		echo $f "- sin reducción ("$(($sorig / 1000)) "KB -->" $(($snew / 1000)) "KB)"
		rm bak.pdf
	fi

done