#!/bin/bash

contsi=0
contno=0

for f in $(find -name "index.html" -exec grep -l "scorm.js" {} \; ); do

	linea=$(grep "scorm.js" $f)

	ruta=$( echo $linea | grep -o '".*scorm.js' | sed 's/.*"//' )

	echo ""
	echo $ruta
	
	carpeta=$(dirname $f)

	rutascorm=$carpeta"/"$ruta

	carpetascorm=$(dirname $rutascorm)
	# echo $carpetascorm

	if [ -e $rutascorm ]; then 
		echo "$rutascorm"
		(( contsi+=1 ))
	else
		echo -e '\e[0;31m'"$rutascorm"'\e[0m'
		(( contno+=1 ))
	fi


done

echo -e '\e[1;33m' "existen" $contsi "y faltan" $contno '\e[0m'
