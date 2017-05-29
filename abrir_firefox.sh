#!/bin/bash

cont=0

min=0
max=30

for f in $( find -name "index.html" ); do

	((cont++))

	if [ $cont -gt $min -a $cont -le $max ]; then
		firefox $f
	fi

done


