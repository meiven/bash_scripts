#!/bin/bash

log="log_meter_scorm.log"
soloactividades=1

> $log

if [ ! -d "zfiles" ]; then
	echo "*** Falta la carpeta 'zfiles'" | tee -a $log
	exit 
fi


for f in $(find . -name "index.html" ); do

	carpeta=$(dirname $f)

	echo "" | tee -a $log
	echo "+++++ $carpeta" | tee -a $log

	editor_notas=$(find $carpeta -maxdepth 3 -name "editor_notas.js" | wc -l)
	subindexhtml=$(find $carpeta -mindepth 2 -name "index.html" | wc -l)

	if [ $soloactividades -eq 1 ]; then
		if [ $subindexhtml -gt 10 ]; then	
			echo "*** $carpeta no es una carpeta de actividad, contiene varios index.html" | tee -a $log
			continue
		fi
	fi


	echo "--- quitando llamadas antiguas a scorm, scormdriver y KitabooCommunicationManager.." | tee -a $log

	sed -e 's/.*scorm.js".*//' -e 's/.*scormdriver.js".*//' -e 's/.*KitabooCommunicationManager.js".*//' $f > temp.html

	rm -rf "$f"
	mv -fv temp.html "$f"  




	echo "--- añadiendo nuevas llamadas a scorm, scormdriver y KitabooCommunicationManager.." | tee -a $log

	sed 's/<\/head>/\n\t<script src="config\/communication\/KitabooCommunicationManager.js"><\/script>\n\t<script src="config\/js\/scormdriver.js"><\/script>\n\t<script src="config\/js\/scorm.js"><\/script>\n<\/head>/' $f > temp.html

	rm -rf "$f"
	mv -fv temp.html "$f"  
	
	
	onunload=$(cat $f | grep "<body onunload" | wc -l)

	if [ $onunload -eq 0 ]; then
		echo "--- añadiendo onunload='salirSCOFinalizado()' a <body> en index.html" | tee -a $log
		sed 's/<body/<body onunload="salirSCOFinalizado()"/' $f > index.html

		rm -rf "$f"
		mv -fv index.html "$f"  
	fi



	existeconfig=$( find $carpeta -maxdepth 1 -name "config" -type d | wc -l )

	if [ ! -d $carpeta"/config" ]; then
		echo "--- creando subcarpeta /config" | tee -a $log
		mkdir -v $carpeta"/config"
	fi

	if [ ! -d $carpeta"/config/js" ]; then
		echo "--- creando subcarpeta /js en /config" | tee -a $log
		mkdir -v $carpeta"/config/js"
	fi

	if [ ! -d $carpeta"/config/communication" ]; then
		echo "--- creando subcarpeta /communication en /config" | tee -a $log
		mkdir -v $carpeta"/config/communication"
	fi

	echo "--- copiando archivos scorm.js, scormdriver.js y KitabooCommunicationManager.js ..." | tee -a $log
	cp -fv zfiles/scorm.js "$carpeta"/config/js/scorm.js
	cp -fv zfiles/scormdriver.js "$carpeta"/config/js/scormdriver.js
	cp -fv zfiles/KitabooCommunicationManager.js "$carpeta"/config/communication/KitabooCommunicationManager.js


done

echo "" | tee -a $log
echo "--- actualizando todos los archivos scorm.js, scormdriver.js y KitabooCommunicationManager.js ..." | tee -a $log

find -mindepth 2 -type f ! -wholename "*zfiles*" -name "scorm.js" -type f -exec cp -v zfiles/scorm.js {} \;
find -mindepth 2 -type f ! -wholename "*zfiles*" -name "scormdriver.js" -type f -exec cp -v zfiles/scormdriver.js {} \;
find -mindepth 2 -type f ! -wholename "*zfiles*" -name "KitabooCommunicationManager.js" -type f -exec cp -v zfiles/KitabooCommunicationManager.js {} \;