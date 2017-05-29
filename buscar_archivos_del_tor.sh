#!/bin/bash

log="log_no_encontradas.log"
>$log

while read -r line || [[ -n $line ]]; do

    busca=$(find -maxdepth 1 -name "$line" | wc -l)

    if [[ $busca -eq 0 ]]; then
    	echo "$line NOOOOOO"
    	echo "$line" >> $log
    else
    	echo "$line si"
    fi

done < "lista.txt"