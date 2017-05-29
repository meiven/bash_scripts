#!/bin/bash

cont=0

for f in $( find -maxdepth 1 -name "*.tar" ); do

	echo "$f"

	new="${f// /_}"
	new2="${new//.tar/}"

	echo $new2

	mkdir $new2

	mv "$f" $new2

	pushd "$new2" > /dev/null
	tar -xvf "$f"
	popd > /dev/null

	((cont++))

done

echo "$cont tars descomprimidos"
