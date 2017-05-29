#!/bin/bash


if [ ! -d "zfiles" ]; then
	echo "*** Falta la carpeta 'zfiles'" | tee -a $log
	exit 
fi


echo "Actualizando todos los archivos scorm.js, scromdriver.js y KitabooCommunicationManager.js ..."

find -mindepth 2 -type f ! -wholename "*zfiles*" -name "scorm.js" -type f -exec cp -v zfiles/scorm.js {} \;
find -mindepth 2 -type f ! -wholename "*zfiles*" -name "scormdriver.js" -type f -exec cp -v zfiles/scormdriver.js {} \;
find -mindepth 2 -type f ! -wholename "*zfiles*" -name "KitabooCommunicationManager.js" -type f -exec cp -v zfiles/KitabooCommunicationManager.js {} \;
