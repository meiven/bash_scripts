#!/bin/bash


echo "marcando la version en todos los index.html"

for f in $(find -name "index.html" -exec grep -l "<!--plantilla" {} \; ); do

	carpeta = $(dirname $f)

	sed -e 's/<!--plantilla.*/<!--plantilla '$fecha'/' "$f" > temp.html
	rm -rf "$f"
	mv -fv temphtml "$carpeta" 	

done
