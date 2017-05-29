#!/bin/bash

contsi=0
contno=0

for f in $(find -name "index.html" -exec grep -l "KitabooCommunicationManager.js" {} \; ); do

	linea=$(grep "KitabooCommunicationManager.js" $f)

	ruta=$( echo $linea | grep -o '".*KitabooCommunicationManager.js' | sed 's/.*"//' )

	echo ""
	echo $ruta
	
	carpeta=$(dirname $f)

	rutaKitaboo=$carpeta"/"$ruta

	carpetaKitaboo=$(dirname $rutaKitaboo)
	# echo $carpetaKitaboo

	if [ -e $rutaKitaboo ]; then 
		echo "$rutaKitaboo"
		(( contsi+=1 ))
	else
		echo -e '\e[0;31m'"$rutaKitaboo"'\e[0m'
		(( contno+=1 ))
	fi


done

echo -e '\e[1;33m' "existen" $contsi "y faltan" $contno '\e[0m'
