#!/bin/bash

echo -e "\nActualizando el número de pantallas en archivos control.json ..."

name="control.json"


for f in $( find -mindepth 2 -name $name ); do

	carpeta="$(dirname $f)"
	numerodatas=$(find $carpeta -maxdepth 1 -name "data*.xml" | wc -l)

	numeromax=$(($numerodatas-1))
	datamax="data"$numeromax".xml"

	echo ""
	echo $carpeta
	echo "numerodatas:" $numerodatas "/ numeromax:" $numeromax " / ultimo data:" $datamax

	if [ -e $carpeta"/"$datamax ]; then

			echo "pantallas:" $numerodatas
			sed -e 's/"pantallas".*/"pantallas": '$numerodatas',/' "$f" > "$name"

			rm -rf "$f"
			mv -fv "$name" "$carpeta" 

	else
		echo "OJO!! revisar la numeración de los archivos data.xml"
	fi

done