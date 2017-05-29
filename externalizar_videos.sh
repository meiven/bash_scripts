#!/bin/bash


for f in $(find -name "*.mp4" ); do

	echo $f
	carpeta1=$(dirname $f)
	carpeta2=$(dirname $carpeta1)

	if [[ $carpeta2 == "resources" ]]; then
		echo "resoruces!"
	fi

done

exit

echo "hola"
