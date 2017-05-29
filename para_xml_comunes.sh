#!/bin/bash


for f in $(find -type f ! -name "*.sh"); do

	l=${f:2}

	ruta="<file href=\"comun/"$l"\"/>"

	echo $ruta

done