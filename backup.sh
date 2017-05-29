#!/bin/bash

cont=1
mkdir "backup_""$1"

echo -e "\nCreando copia de seguridad de todos los archivos $1 mayores de $2 KB en" "backup_""$1"

for f in $( find -mindepth 2 -name "*.""$1" -size +"$2"k ); do
	new=bkp"$cont"."$1"
	((cont++))

	cp -fv "$f" "backup_""$1"/"$new"
done
