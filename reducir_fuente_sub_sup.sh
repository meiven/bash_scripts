#!/bin/bash


for f in $(find -name "layout.css"); do

	echo $f
	echo -e "\n\nsub, sup {font-size: 80%;}" >> $f

done