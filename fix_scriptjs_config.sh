#!/bin/bash

cont=0
subindex=0
configcont=0

echo -e "\neliminando la linea jQuery(\"#respuestasOld\").css('display','block'); de todos los archivos 'script.js' que no están en una carpeta 'config'\n"

for f in $(find -name "script.js" -exec grep -l "" {} \; ); do

	folder=$(dirname $f)

	existeconfig=$( echo $folder | grep -o 'config' | wc -w )
	# echo $existeconfig

	if [ $existeconfig -lt 1 ]; then
		#echo $f '"no está en carpeta "config"'

		tieneRespuestasOldA=$(grep -l "jQuery(\"#respuestasOld\").css('display','block')" $f | wc -l )

		tieneRespuestasOldB=$(grep -l 'jQuery("#respuestasOld").css("display","block")' $f | wc -l )

		(( tieneRespuestasOld = tieneRespuestasOldA + tieneRespuestasOldB ))

		if [ $tieneRespuestasOld -gt 0 ]; then

			((cont++))
			
			echo $f

			sed -e "s/jQuery(\"#respuestasOld\").css('display','block')/jQuery(\"#respuestasOld\").css('display','none')/g" -e 's/jQuery("#respuestasOld").css("display","block")/jQuery("#respuestasOld").css("display","none")/g' $f > script.js 

			rm -rf "$f"
			mv -f script.js $folder 

		fi
 
	fi

done

echo $cont "archivos 'script.js' cambiados"

