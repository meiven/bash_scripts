#!/bin/bash

for objetivo in $( find -mindepth 2 -name "scorm.js" ); do

	nombre=$(basename $objetivo)
	
	grep -l 'mensajeFinalSCO= "Hemos llegado al final de este ejercicio. Has conseguido " + (puntuacionScoAcumulada\/10) + " puntos sobre 10. Puedes salir de la actividad o volver a comenzar de nuevo.' $objetivo

	sed 's/mensajeFinalSCO= "Hemos llegado al final de este ejercicio. Has conseguido " + (puntuacionScoAcumulada\/10) + " puntos sobre 10. Puedes salir de la actividad o volver a comenzar de nuevo."/mensajeFinalSCO=""/' "$objetivo" > "$nombre" 

	dirobjetivo="$(dirname "$objetivo")"
	rm -rf "$objetivo"
	mv -f "$nombre" "$dirobjetivo"  

done

