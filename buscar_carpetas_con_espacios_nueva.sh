#!/bin/bash

log=log_carpetas_con_espacios.log
> $log

echo -e "\nbuscando carpetas que contienen espacios ..."

find -type d | while read f
do
	g=$(basename "$f")

	if [[ "$g" =~ " " ]];then
   	    	
    	echo "$f" | tee -a $log

    	numindex=$(find "$f" -type f -name "index.html" | wc -l)
    	echo -e "(contiene "$numindex" actividades)\n" | tee -a $log

    fi

done