#!/bin/bash

cont=0
ruta="/home/ubuntu/Escritorio/_me/0_fisica/contenidos/recursos/videos/"

for f in $( find -name "*.flv" ); do

	((cont++))

	nombre=$(basename $f)

	destino="$ruta""$nombre" 

	#echo $destino
	cp -fv $f $destino

done


