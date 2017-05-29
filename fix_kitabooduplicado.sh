#!/bin/bash

contsi=0
contno=0

for f in $(find -mindepth 2 -name "script.js" -exec grep -l "KitabooCommunicationManager.sendActivityData(result, res, this.total);" {} \; ); do

	sed 's/KitabooCommunicationManager.sendActivityData(result, res, this.total);/KitabooCommunicationManager.sendActivityData(this.aciertos, res, this.total);/' "$f" > script.js 

	rm -rf "$f"
	mv -fv script.js "$f"  



	ruta=$(dirname $f)
	rutaact=$ruta"/"act_seleccionar.js

	sed -e 's/if (Scorm_conectado()){gestionarSCO(pantallas, currentIndex, 1);}/\/\/if (Scorm_conectado()){gestionarSCO(pantallas, currentIndex, 1);}/' -e 's/if (Scorm_conectado()){gestionarSCO(pantallas, currentIndex, 0);}/\/\/if (Scorm_conectado()){gestionarSCO(pantallas, currentIndex, 0);}/' "$rutaact" > act_seleccionar.js 

	rm -rf "$rutaact"
	mv -fv act_seleccionar.js "$rutaact"

done

