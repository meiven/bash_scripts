#!/bin/bash

cadena_old="function sacarSolucionInput(){"
cadena_new="function sacarSolucionInput(){\n\tvar fail = jQuery('#text > div#inputSelect .fail');\n\tvar ok = jQuery('#text > div#inputSelect .ok');\n"
archivos="act_input_select.js"

for objetivo in $( find -mindepth 1 -name "$archivos" -exec grep -l "$cadena_old" {} \; ); do

	echo $objetivo

	nombre=$(basename $objetivo)

	#echo $(cat $objetivo | grep "actDragnDropFinalizada(estado);" | wc -l)
	
	#sed 's/'$cadena_old'/'$cadena_new'/' "$objetivo" > "$nombre" 
	#sed 's/'$cadena_old'/'$cadena_new'/' "$objetivo" > "nuevo2.test"
	sed "s/""$cadena_old""/""$cadena_new""/" "$objetivo" > "test.js"

	#dirobjetivo="$(dirname "$objetivo")"
	#rm -rf "$objetivo"
	#mv -fv "$nombre" "$dirobjetivo"  

done

