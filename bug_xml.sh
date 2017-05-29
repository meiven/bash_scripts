#!/bin/bash

cont=0

# > _bug_if_false.log

echo -e "\nbuscando 'if(false)' en archivos jquery.control.js en todas las actividades que contienen archivos data0.xml ..."

for f in $(find -name "data0.xml" ); do

	folder=$(dirname $f)

	for j in $(find $folder -name "jquery.control.js" -exec grep -l "if(false)" {} \;); do

		((cont++))
		echo $j #| tee -a "_bug_if_false.log"

	done

done

echo $cont "actividades con problemas"