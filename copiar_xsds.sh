#!/bin/bash

soloactividades=1

if [ ! -d "zfiles" ]; then
	echo "*** Falta la carpeta 'zfiles'" | tee -a $log
	exit 
fi


for f in $( find -mindepth 1 -name "index.html" ); do

	carpeta=$(dirname $f)
	

	editor_notas=$(find $carpeta"/config" -name "editor_notas.js" | wc -l)
	subindexhtml=$(find $carpeta -mindepth 2 -name "index.html" | wc -l)

	if [ $soloactividades -eq 1 ]; then
		if [ $subindexhtml -gt 10 ]; then	
			echo "*** $carpeta no es una carpeta de actividad, contiene varios index.html" | tee -a $log
			continue
		fi
	fi

	echo ""
	echo "copiando archivos .xsd y .xml comunes ..."
	find zfiles ! -name "plantilla_manifest.xml" -name "*.x*" -exec cp -v {} "$carpeta" \;

done



