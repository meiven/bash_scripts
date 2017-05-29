#!/bin/bash

cont=0

for f in $( find -name "datos" -type d ); do

	echo ""

	folder=$(dirname "$f")
	echo $folder

	algunxml=$( find $folder -maxdepth 1 -name "data1.xml" | wc -l)
	echo $algunxml

	if [ $algunxml -eq 0 ]; then

		for j in $(find $folder -name "jquery.control.js" -exec grep -l "if(currentIndex != pantallas)" {} \;); do

			echo $j

			sed 's/if(currentIndex != pantallas)/if(false)/' $j > jquery.control.js 

			dirobjetivo="$(dirname "$j")"
			rm -rf "$j"
			mv -fv jquery.control.js "$j"  

		done
	fi

done


