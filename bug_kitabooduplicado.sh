#!/bin/bash

contsi=0
contno=0

for f in $(find -mindepth 2 -name "script.js" -exec grep -l "KitabooCommunicationManager.sendActivityData(result, res, this.total);" {} \; ); do

	ruta=$(dirname $f)
	rutaact=$ruta"/"act_seleccionar.js

	if [ -e $rutaact ]; then 
		otro=$(grep "Kitaboo" $rutaact | wc -l)
		if [ $otro -gt 0 ]; then
			echo $f
			echo $rutaact
		fi
	fi

done

