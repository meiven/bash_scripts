#!/bin/bash

echo -e "\nbuscando carpetas que contienen espacios ..."
find -mindepth 1 -type d | while read f
do
	if [[ "$f" =~ " " ]];then
   	
    	echo "$f"

    fi

done