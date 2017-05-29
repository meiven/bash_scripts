#!/bin/bash

echo -e "\nborrando todos los directorios que contienen espacios ..."
find -mindepth 2 -type d | while read f
do
	if [[ "$f" =~ " " ]];then
   	
    	rm -Rfv "$f"

    fi

done