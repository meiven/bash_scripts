#!/bin/bash

cadena="Plantilla Anaya Educación v1.0"


echo "insertando marca en todos los archivos.."

fecha=$(date +"%d\/%m\/%y")
cadenatotal="$cadena"" - Actualizada el ""$fecha"

cadenatotaljs="\/\/ ""$cadenatotal"
cadenatotalhtml="<!-- ""$cadenatotal"" -->"

echo $cadenatotaljs
echo $cadenatotalhtml

for f in $(find -mindepth 2 -name "*.js" ! -wholename "zfiles"); do

	nombre="$(basename "$f")"
	carpeta="$(dirname "$f")"

	primeralinea=$(head -1 $f)
	echo $primeralinea

	hay=$(echo "$primeralinea" | grep "Actualizada el" | wc -l);
	echo $hay

	if [[ $hay -eq 1 ]];then
		sed -e '1s/.*//' "$f" > $nombre
		echo "borrada"
	fi

	carpeta="$(dirname "$f")"
	rm -rf "$f"
	mv -fv "$nombre" "$carpeta"  

done



for f in $(find -mindepth 2 -name "*.html" ! -wholename "zfiles"); do

	nombre="$(basename "$f")"
	carpeta="$(dirname "$f")"

	primeralinea=$(head -1 $f)
	echo $primeralinea

	hay=$(echo "$primeralinea" | grep "Actualizada el" | wc -l);
	echo $hay

	if [[ $hay -eq 1 ]];then
		sed -e '1s/.*//' "$f" > $nombre
		echo "borrada"
	fi

	carpeta="$(dirname "$f")"
	rm -rf "$f"
	mv -fv "$nombre" "$carpeta"  

done