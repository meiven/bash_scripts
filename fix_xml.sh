#!/bin/bash

cont_cambiadas=0

> _fixed_if_false.log

echo -e "\nsustituyendo 'if(false)' por 'if(currentIndex != pantallas)' de los archivos jquery.control.js en todas las actividades que contienen archivos data0.xml ..."

for f in $(find -name "data0.xml" ); do

	folder=$(dirname $f)

	for j in $(find $folder -name "jquery.control.js" -exec grep -l "if(false)" {} \;); do

		((cont_cambiadas++))
		echo $j | tee -a "_fixed_if_false.log"

		sed 's/if(false)/if(currentIndex != pantallas)/' $j > jquery.control.js 

		dirobjetivo="$(dirname "$j")"
		rm -rf "$j"
		mv -fv jquery.control.js "$j"  

	done

done

echo $cont_cambiadas "actividades arregladas"