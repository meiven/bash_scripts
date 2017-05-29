#!/bin/bash

cadena_old="estilo.css"
cadena_new="..\/estilo.css"
archivos="*.html"

for objetivo in $( find -mindepth 2 -name "$archivos" -exec grep -l "$cadena_old" {} \; ); do

	echo $objetivo

	nombre=$(basename $objetivo)

	#echo $(cat $objetivo | grep "actDragnDropFinalizada(estado);" | wc -l)

	sed 's/'$cadena_old'/'$cadena_new'/' "$objetivo" > "$nombre"

	dirobjetivo="$(dirname "$objetivo")"
	rm -rf "$objetivo"
	mv -fv "$nombre" "$dirobjetivo"  

done


cadena_old="..\/..\/"
cadena_new="..\/..\/recursosMathJax\/"
archivos="*.html"

for objetivo in $( find -mindepth 2 -name "$archivos" -exec grep -l "$cadena_old" {} \; ); do

	echo $objetivo

	nombre=$(basename $objetivo)

	sed 's/'$cadena_old'/'$cadena_new'/' "$objetivo" > "$nombre"

	dirobjetivo="$(dirname "$objetivo")"
	rm -rf "$objetivo"
	mv -fv "$nombre" "$dirobjetivo"  

done

