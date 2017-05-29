#!/bin/bash

echo -e "\nrenombrando todos los directorios que contienen espacios ..."

log="errores_carpetas_con_espacios.log"
> $log

find -mindepth 2 -depth -type d | while read d
do
	name=$(basename "$d")
	carpeta=$(dirname "$d")
	echo ""
	echo "$d"
	echo "$name"
	echo "$carpeta"

	if [[ "$name" =~ " " ]];then

	    newname="${name// /XXX}"
	    echo "new: "$newname
        cp -Rfv "$d" "$carpeta""/""$newname"
        echo "$d"" copiada a ""$carpeta""/""$newname" | tee -a $log
    fi

done


echo ""
find -mindepth 2 -depth -type d | while read d
do
	name=$(basename "$d")
	if [[ "$name" =~ " " ]];then
   	
    	rm -Rfv "$d"

    fi
done