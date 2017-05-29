#!/bin/bash

> carpetas_subidas.log

for f in $(find -maxdepth 1 -type d ); do

	nombre1=$(basename "$f")

	for g in $(find $f -mindepth 1 -maxdepth 1 -name "${nombre1}*" -type d ); do

		pushd "$g" > /dev/null
		mv ./* ../
		popd > /dev/null
		
		rm -rf $g

		echo $g | tee -a "carpetas_subidas.log"

	done

done

