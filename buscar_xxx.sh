#!/bin/bash

find -mindepth 2 -type f | while read f
do
	if [[ "$f" =~ "XXX" ]];then
   	
    	echo "$f"

    fi

done