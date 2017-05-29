#!/bin/bash

echo -e "\nvolviendo a poner espacios en los directorios ..."

find -mindepth 2 -type d | while read f
do
	if [[ "$f" =~ "XXX" ]]; then

	    new="${f//XXX/ }"

	    a=$(find "$new" 2> /dev/null)

		if [ $? != 0 ]; then
			echo ""
			echo "renombrando $new"
			cp -Rfv "$f" "$new"
		fi
	    
    fi
done


echo ""
echo "borrando las carpetas con XXX.."

find -mindepth 2 -type d | while read f
do
	if [[ "$f" =~ "XXX" ]]; then
    	rm -Rfv "$f"
    fi
done