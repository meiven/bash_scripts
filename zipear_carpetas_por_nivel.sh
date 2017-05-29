#!/bin/bash

nivel=1

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

