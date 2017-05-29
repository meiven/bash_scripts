#!/bin/bash


if [ ! -d "scripts_para_comprobar_zips" ]; then
	echo "*** Falta la carpeta 'scripts_para_comprobar_zips'" | tee -a $log
	exit 
fi


for f in $(find -name "*.zip"); do

	nombre=$(basename "$f")
	carpeta=$(dirname "$f")
	nombre_carpeta=$(basename "$carpeta")

	echo ""
	echo "$f"
	echo "$nombre"
	echo "$carpeta"
	echo "$nombre_carpeta"

	rm -fr temp
	mkdir temp
	if [ $? != 0 ]
    then
    	echo -e "\nERROR\nno hay permiso para crear directorios en $carpeta \n"
    	exit
    fi
	cp -r scripts_para_comprobar_zips/* temp

	unzip "$f" -d "temp/actividad"

	#rm -fv "$nombre"

	pushd "temp" > /dev/null

		echo "dentro del zip..."

		###### dentro del zip, codigo aquí
		chmod +x *.sh
		./00_SCORM_y_codigo_antiguo.sh
		if [ $? != 0 ]
	    then
	    	echo -e "\nERROR\nno hay permiso para ejecutar scripts en la carpeta $carpeta \n"
	    	exit
	    fi
		######

		pushd "actividad" > /dev/null
			zip -r "$nombre" *
		popd > /dev/null

	popd > /dev/null

	mv "temp/actividad/""$nombre" "$f"

	rm -fr temp
	
done

