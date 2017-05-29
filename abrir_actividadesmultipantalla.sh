#!/bin/bash

cont=0

for f in $( find -name "data1.xml" ); do

	carpeta=$(dirname "$f")

	for index in $( find $carpeta -maxdepth 1 -name "index.html");do

		((cont++))

		if [ $cont -lt 10 ]; then
			firefox $index
		fi

	done

done


