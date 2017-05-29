#!/bin/bash


for f in $(find -name "index.html" -exec grep -L 'id="siguiente"' {} \; ); do
	
	carpeta=$(dirname $f)

	if [ ! -d $carpeta"/config" ]; then

		if [ -e $carpeta"/data1.xml" ]; then 
			echo "$f"
			(( contsi+=1 ))
		fi

	fi

done

