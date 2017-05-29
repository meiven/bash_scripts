#!/bin/bash

echo ""
echo "quitando espacios de nombres de archivo ..."
find -mindepth 2 -type f | while read f
do
	nombre=$(basename "$f")
	if [[ "$nombre" =~ " " ]];then
   	
    	new="${f// /XXX}"
    	mv -fv "$f" "$new"

    fi

done