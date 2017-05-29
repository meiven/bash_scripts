#!/bin/bash

cadena_old="estilo.css"
cadena_new="..\/estilo.css"
archivos="*.html"

for objetivo in $( find -name "$archivos" -exec grep -l "$cadena_old" {} \; ); do

	echo $objetivo

	nombre=$(basename $objetivo)

	#echo $(cat $objetivo | grep "actDragnDropFinalizada(estado);" | wc -l)

	sed 's/'$cadena_old'/'$cadena_new'/' "$objetivo" > bla

	dirobjetivo="$(dirname "$objetivo")"
	rm -rf "$objetivo"
	mv -fv bla "$dirobjetivo"  

done

