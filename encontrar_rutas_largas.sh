#!/bin/bash

longmax=0
file=""
target=$1||10000

echo ""
echo "buscando archivos con rutas de más de $target caracteres:"
for f in $(find -type f ); do

	long=$(echo $f | wc -c)

	if [[ long -gt $target ]]; then
		echo $long "->" $f
	fi

	if [[ long -gt $longmax ]]; then
		longmax=$long
		file=$f
	fi

done

echo "------"
echo "la ruta más larga es la del archivo $file, con $longmax caracteres"
echo ""


