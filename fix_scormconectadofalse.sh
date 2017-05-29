#!/bin/bash

contsi=0
contno=0

for f in $(find -mindepth 2 -name "index.html" -exec grep -l "scorm.js" {} \; ); do

	linea=$(grep "scorm.js" $f)
	ruta=$( echo $linea | grep -o -P '(?<=").*(?=">)' )
	carpeta=$(dirname $f)
	rutascorm=$carpeta"/"$ruta
	carpetascorm=$(dirname $rutascorm)
	# echo $carpetascorm

	if [ -e $rutascorm ]; then 
		(( contsi+=1 ))
	else

		echo $rutascorm
		(( contno+=1 ))

		lineaS=$(grep "script.js" $f)
		rutaS=$( echo $lineaS | grep -o -P '(?<=").*(?=">)' )
		rutascript=$carpeta"/"$rutaS
		
		echo $rutascript	
		echo ""

		sed 's/function Scorm_conectado_OLD()/function Scorm_conectado(){return false;};function Scorm_conectado_OLD()/' "$rutascript" > script.js 

		rm -rf "$rutascript"
		mv -fv script.js "$rutascript"  

	fi

done

echo "arreglados" $contno", dejados igual" $contsi
