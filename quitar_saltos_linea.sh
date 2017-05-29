#!/bin/bash

cadena_old='\n'
cadena_new='@'
archivos="index.html"

for objetivo in $( find -mindepth 1 -name "$archivos" ); do

	echo $objetivo

	nombre=$(basename $objetivo)

	#echo $(cat $objetivo | grep "actDragnDropFinalizada(estado);" | wc -l)
	
	#sed 's/'$cadena_old'/'$cadena_new'/' "$objetivo" > "$nombre" 
	cat "$objetivo" | tr '\n' '@' > 1"$nombre"

	sed "s/@@@*/@@/g" 1"$nombre" > 2"$nombre"

	sed "s/@/\n/g" 2"$nombre" > "$nombre"

	dirobjetivo="$(dirname "$objetivo")"
	rm -rf "$objetivo"
	mv -fv "$nombre" "$dirobjetivo"  

done

