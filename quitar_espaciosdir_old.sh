#!/bin/bash

echo -e "\nrenombrando todos los directorios que contienen espacios ..."


find -mindepth 2 -type d | while read f
do
	if [[ "$f" =~ " " ]];then

	    new="${f// /XXX}"

	    a=$(find "$new" 2> /dev/null)

	   if [ $? != 0 ]; then
	   	    echo ""
	    	echo "renombrando $f"
	       cp -Rfv "$f" "$new"
	   fi

    fi
done


echo ""
find -mindepth 2 -type d | while read f
do
	if [[ "$f" =~ " " ]];then
   	
    	rm -Rfv "$f"

    fi
done