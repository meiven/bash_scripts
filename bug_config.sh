#!/bin/bash

contsi=0
contno=0

echo -e "\nbuscando todos los archivos 'script.js' que no están en una carpeta 'config'\n"

for f in $(find -name "script.js" -exec grep -l "" {} \; ); do

	folder=$(dirname $f)

	existeconfig=$( echo $folder | grep -o 'config' | wc -w )
	#echo $existeconfig

	if [ $existeconfig -lt 1 ]; then
		# echo $f
		(( contno++ ))
		echo $f
 	else
 		(( contsi++ ))
	fi

done

echo $contno "archivos script.js no están carpeta config," $contsi "sí están"