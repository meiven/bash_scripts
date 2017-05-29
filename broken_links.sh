#!/bin/bash

if [ ! -e "quitar_espacios_en_carpetas.sh" ]; then
	echo 'falta el script "quitar_espacios_en_carpetas.sh"'
	exit
fi

if [ ! -e "poner_espacios_en_carpetas.sh" ]; then
	echo 'falta el script "poner_espacios_en_carpetas.sh"'
	exit
fi

./quitar_espacios_en_carpetas.sh

log="log_enlaces_borrados.txt"

echo "enlaces borrados:" > $log




for indexes in $(find -name "index.html"); do

	echo $indexes
	carpeta=$(dirname $indexes)
	echo $carpeta
	clean_carpeta="${carpeta//\.\//}"
	echo $clean_carpeta

	for lineas in $(find $carpeta -name "index.html" -exec grep -e 'src=".*\.js"></script>' {} \;); do
		
		file=$( echo $lineas | grep -oP "(?<=src=\").*?(?=\")" )

		chars=$(echo $file | wc -c)

		if [ $chars -gt 2 ]; then
			echo $file

			filetotal=$(pwd)"/"$clean_carpeta"/"$file
			echo $filetotal

			if [ -e $filetotal ]; then
				echo "existe!"
			else
				echo "noooooo existe"
				grep -v "$file" $indexes > temp && mv temp $indexes

				echo $clean_carpeta"/"$file >> $log
				
			fi
			echo "----"


		fi
		

	done

done


./poner_espacios_en_carpetas.sh