#!/bin/bash

cont=0
subindex=0
configcont=0

echo -e "\nbuscando la linea jQuery(\"#respuestasOld\").css('display','block') en todos los archivos 'script.js' que no están en una carpeta 'config'\n"

for f in $(find -name "script.js" -exec grep -l "" {} \; ); do

	folder=$(dirname $f)

	existeconfig=$( echo $folder | grep -o 'config' | wc -w )
	#echo $existeconfig

	if [ $existeconfig -lt 1 ]; then
		# echo $f

		tieneRespuestasOldA=$(grep -l "jQuery(\"#respuestasOld\").css('display','block')" $f | wc -l )

		tieneRespuestasOldB=$(grep -l 'jQuery("#respuestasOld").css("display","block")' $f | wc -l )

		(( tieneRespuestasOld = tieneRespuestasOldA + tieneRespuestasOldB))
		# echo $tieneRespuestasOld

		if [ $tieneRespuestasOld -gt 0 ]; then

			((cont++))

			echo $f
		fi
 
	fi

done

echo $cont "archivos problematicos"