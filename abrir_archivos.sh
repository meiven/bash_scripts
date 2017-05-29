#!/bin/bash

cont=0

min=0
max=30

for f in $( find -name "*.flv" ); do

	((cont++))

	if [ $cont -gt $min -a $cont -le $max ]; then
		totem $f
		# nohup totem $f &
	fi

done


