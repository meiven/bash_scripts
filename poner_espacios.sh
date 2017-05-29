#!/bin/bash

echo ""
echo "volviendo a poner espacios ..."
find -mindepth 2 -type f | while read f
do
	nombre=$(basename "$f")
	if [[ "$nombre" =~ "XXX" ]];then
   		
    	new="${f//XXX/ }"
    	mv -fv "$f" "$new"

    fi

done