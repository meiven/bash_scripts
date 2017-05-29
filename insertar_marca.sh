#!/bin/bash

cadena="Plantilla Anaya Educación v1.0"


echo "insertando marca en todos los archivos index.html .."

fecha=$(date +"%d\/%m\/%y")
cadenatotal="$cadena"" - Actualizada el ""$fecha"

cadenatotaljs="\/\/ ""$cadenatotal"
cadenatotalhtml="<!-- ""$cadenatotal"" -->"

echo $cadenatotaljs
echo $cadenatotalhtml



for f in $(find -mindepth 2 -name "index.html" ! -wholename "zfiles"); do

	nombre="$(basename "$f")"
	carpeta="$(dirname "$f")"

	primeralinea=$(head -1 $f)
	echo $primeralinea

	hay=$(echo "$primeralinea" | grep "Actualizada el" | wc -l);
	echo $hay

	if [[ $hay -eq 0 ]];then
		sed -e '1s/^/'"$cadenatotalhtml"'\n\n/' "$f" > $nombre
		echo "no tiene marca, creando nueva"
	else
		echo "ya tiene marca, actualizando"
		sed -e '1s/.*/'"$cadenatotalhtml"'/' "$f" > $nombre
	fi

	carpeta="$(dirname "$f")"
	rm -rf "$f"
	mv -fv "$nombre" "$carpeta"  

done

exit



#si se quieren insertar marcas en los archivos .js también

for f in $(find -mindepth 2 -name "*.js" ! -wholename "zfiles"); do

	nombre="$(basename "$f")"
	carpeta="$(dirname "$f")"

	primeralinea=$(head -1 $f)
	echo $primeralinea

	hay=$(echo "$primeralinea" | grep "Actualizada el" | wc -l);
	echo $hay

	if [[ $hay -eq 0 ]];then
		sed -e '1s/^/'"$cadenatotaljs"'\n\n/' "$f" > $nombre
		echo "no tiene"
	else
		echo "ya tiene"
		sed -e '1s/.*/'"$cadenatotaljs"'/' "$f" > $nombre
	fi

	carpeta="$(dirname "$f")"
	rm -rf "$f"
	mv -fv "$nombre" "$carpeta"  

done


