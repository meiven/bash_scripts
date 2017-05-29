#!/bin/bash

cont=0
> log_no_zipeadas.txt

find -mindepth 2 -name "index.html" | while read f; do

	if [[ "$f" =~ " " ]];then
		echo "$f" "- la ruta tiene espacios" | tee -a "log_no_zipeadas.txt"
	else

		carpeta=$(dirname "$f")
		nombrecarpeta=$(basename "$carpeta")
		subindexhtml=$(find $carpeta -mindepth 2 -name "index.html" | wc -l)
		zips=$(find "$carpeta" -name "*.zip" | wc -l)

		if [ $subindexhtml -eq 0 ]; then

			if [ $zips -gt 0 ];then
				echo "$carpeta" "- ya contiene un archivo .zip" | tee -a "log_no_zipeadas.txt"
			else			

				pushd "$carpeta" > /dev/null
				zip -qr "$nombrecarpeta".zip .
				popd > /dev/null

				echo "$carpeta" zipeada
				((cont++))
			fi
		fi
	fi

done

echo "$cont nuevas carpetas zipeadas"
