#!/bin/bash

cont=0
> log_no_tareada.log


find -mindepth 2 -name "structure.xml" | while read f;do

	echo "$f"

	carpeta=$(dirname "$f")
	nombrecarpeta=$(basename "$carpeta")
	tars=$(find "$carpeta" -maxdepth 1 -name "*.tar" | wc -l)

	if [ $tars -gt 0 ];then
		echo "$carpeta" "- ya contiene un archivo .tar" | tee -a "log_no_tareada.log"
	else	
		((cont++))		
		pushd "$carpeta" > /dev/null
		tar -cvf "$nombrecarpeta".tar *
		popd > /dev/null

		echo "$carpeta" "tareada"
	fi

done

echo "$cont" "nuevas carpetas tareadas"
