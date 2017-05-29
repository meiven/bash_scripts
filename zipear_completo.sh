#!/bin/bash

nivel=1

find -name "*.zip" -exec rm -fv {} \;

find -mindepth $nivel -maxdepth $nivel -type d | while read f; do

	if [[ "$f" =~ " " ]];then
		echo "$f" "- la ruta tiene espacios" | tee -a "log_no_zipeadas.txt"
	else

		nombrecarpeta=$(basename "$f")
			
		pushd "$f" > /dev/null
		zip -qr "$nombrecarpeta".zip .
		popd > /dev/null

	fi


done



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

	mv -v $f $nombre

done

