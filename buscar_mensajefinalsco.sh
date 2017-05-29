#!/bin/bash


for f in $( find -mindepth 2 -name "scorm.js" ); do

	nombre=$(basename $f)
	
	grep -l 'mensajeFinalSCO= "Hemos llegado al final de este ejercicio. Has conseguido " + (puntuacionScoAcumulada\/10) + " puntos sobre 10. Puedes salir de la actividad o volver a comenzar de nuevo.' $f

done

