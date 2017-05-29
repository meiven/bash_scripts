#!/bin/bash

#ruta="/bin/yuicompressor-2.4.8.jar"

cont=0
total=$( find -mindepth 2 -regex '.*\.\(js\|css\)' | wc -l)

for f in $( find -mindepth 2 -regex '.*\.\(js\|css\)' ); do

	((cont++))

	echo $cont"/"$total $f

	yui-compressor "$f" -o "$f"

done