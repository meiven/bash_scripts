#!/bin/bash

for f in $(find -name "index.html"); do

	linea=$(grep ".pdf" $f)
	echo $linea
	
	linea2="${linea// /XXX}"

	echo ""
	#echo $linea | grep -oP "(?<=href=\").*?(?=.pdf)"
	for file in $( echo $linea2 | grep -oP "(?<=href=\").*?(?=\")" ); do
		file2="${file// /XXX}"
		echo $file2
	done

	echo ""
	echo "-------------------"
	echo ""

	#ruta=$( echo $linea | grep o -P '(?<=").*(?=">)' )
	#echo $ruta

done
