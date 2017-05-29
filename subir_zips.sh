#!/bin/bash


echo -e "\nsubiendo zips al primer nivel ..."

for f in $( find -mindepth 2 -name "*.zip" ); do

	echo ""
	nombre=$(basename $f)
	carpeta=$(dirname $f)

	cantidadzips=$( find -mindepth 2 -name "$nombre" | wc -l)

	if [[ $cantidadzips -gt 1 ]]; then	
		echo ""
		echo "hay $cantidad archivos $nombre"
		find -mindepth 2 -name $nombre
		nombre="${f//\//__}"
		nombre=${nombre:1}
		echo $nombre
	fi

	cp -v $f $nombre

done

