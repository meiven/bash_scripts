#!/bin/bash


if [ ! -d "zfiles" ]; then
	echo "*** Falta la carpeta 'zfiles'" | tee -a $log
	exit 
fi
