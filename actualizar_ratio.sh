#!/bin/bash


soloactividades=0

logno=$(pwd)/log_actualizar_ratio_errores.log
logsi=$(pwd)/log_actualizar_ratio_OK.log

> $logno
> $logsi


#################################################


check(){

	lineas=$(grep "$1" "$f" | wc -l)

	if [[ lineas -eq 0 ]]; then
		echo "!! no se ha actualizado ""$f"" (no contiene la cadena '""$1""')" | tee -a $logsi
		echo "!! no se ha actualizado ""$carpeta""/""$f"" (no contiene la cadena '""$1""')" >> $logno
		continue
	fi

}


checkno(){

	lineas=$(grep "$1" "$f" | wc -l)

	if [[ lineas -gt 0 ]]; then
		echo "$f"" OK  [ya contenía '""$1""']" | tee -a $logsi
		continue
	fi

}


makesed(){

	carpeta=$(dirname $f)

	sed -e "$1" "$f" > "$name"
	rm -f "$f"
	mv -f "$name" "$carpeta" 

}


#################################################


for act in $(find -name "index.html" ); do

	carpeta=$(dirname $act)

	echo -e "\n##### $carpeta" | tee -a $logsi


	editor_notas=$(find $carpeta -maxdepth 3 -name "editor_notas.js" | wc -l)
	subindexhtml=$(find $carpeta -mindepth 2 -name "index.html" | wc -l)

	if [ $soloactividades -eq 1 ]; then
		if [ $subindexhtml -gt 10 ]; then	
			echo "*** $carpeta no es una carpeta de actividad, contiene varios index.html" | tee -a $log
			continue
		fi
	fi
	

	pushd "$carpeta" > /dev/null



	name="act_dragndrop.js"

	for f in $( find -mindepth 2 -name $name ); do

		checkno "gestionarSCO(pantallas, currentIndex, ratio)"

		check "function actDragnDropFinalizada"
		check "gestionarSCO(pantallas, currentIndex, 0);"

		makesed 's/function actDragnDropFinalizada.*/function actDragnDropFinalizada(Estado, ratio){/'
		makesed 's/gestionarSCO(pantallas, currentIndex, 0)/gestionarSCO(pantallas, currentIndex, ratio)/'
		makesed 's/actDragnDropFinalizada(estado)/actDragnDropFinalizada(estado, ok\/drag_arr.length)/'

		echo "$f actualizada OK" | tee -a $logsi

	done



	name="act_seleccionar.js"

	for f in $( find -mindepth 2 -name $name ); do

		checkno "gestionarSCO(pantallas, currentIndex, ratio)"

		check "clickmal++;"
		check "}); //FIN RESPUESTA"
		check "actClickFinalizada(estado)"
		check "function actClickFinalizada"
		check "gestionarSCO(pantallas, currentIndex, 0)"

		makesed 's/clickmal++;/\n\t\trespCorrTotales = 0;\n\t\ttotalCorrPregTotales = 0;\n\t\t\n\t\tclickmal++;/'
		makesed 's/}); \/\/FIN RESPUESTA/}); \/\/FIN RESPUESTA\n\n\t\t\trespCorrTotales += respCorr;\n\t\t\ttotalCorrPregTotales += totalCorrPreg;/'
		makesed 's/actClickFinalizada(estado)/actClickFinalizada(estado, respCorrTotales\/totalCorrPregTotales)/'
		makesed 's/function actClickFinalizada.*/function actClickFinalizada(Estado, ratio){/'
		makesed 's/gestionarSCO(pantallas, currentIndex, 0)/gestionarSCO(pantallas, currentIndex, ratio)/'

		echo "$f actualizada OK" | tee -a $logsi

	done



	name="act_input_select.js"

	for f in $( find -mindepth 2 -name $name ); do

		checkno "gestionarSCO(pantallas, currentIndex, ratio)"

		check "actInputFinalizada(estado)"
		check "function actInputFinalizada"
		check "gestionarSCO(pantallas, currentIndex, 0)"

		makesed 's/actInputFinalizada(estado)/actInputFinalizada(estado, ok.length\/ans_arr.length)/'
		makesed 's/function actInputFinalizada.*/function actInputFinalizada(Estado, ratio){/'
		makesed 's/gestionarSCO(pantallas, currentIndex, 0)/gestionarSCO(pantallas, currentIndex, ratio)/'

		echo "$f actualizada OK" | tee -a $logsi

	done



	name="act_relacionar.js"

	for f in $( find -mindepth 2 -name $name ); do

		checkno "gestionarSCO(pantallas, currentIndex, ratio)"

		check "actRelacionarFinalizada(estado);"
		check "function actRelacionarFinalizada"
		check "gestionarSCO(pantallas, currentIndex, 0);"

		makesed 's/actRelacionarFinalizada(estado);/actRelacionarFinalizada(estado, arr_bien.length \/ pointCreados);/'
		makesed 's/function actRelacionarFinalizada.*/function actRelacionarFinalizada(Estado, ratio){/'
		makesed 's/gestionarSCO(pantallas, currentIndex, 0);/gestionarSCO(pantallas, currentIndex, ratio);/'

		echo "$f actualizada OK" | tee -a $logsi

	done




	name="act_sortable.js"

	for f in $( find -mindepth 2 -name $name ); do

		checkno "gestionarSCO(pantallas, currentIndex, ratio)"

		check "function actSortableFinalizada"
		check "actSortableFinalizada(estado)"
		check "gestionarSCO(pantallas, currentIndex, 0)"

		makesed 's/actSortableFinalizada(estado)/actSortableFinalizada(estado, done.length\/numListas)/'
		makesed 's/function actSortableFinalizada.*/function actSortableFinalizada(Estado, ratio){/'
		makesed 's/gestionarSCO(pantallas, currentIndex, 0)/gestionarSCO(pantallas, currentIndex, ratio)/'

		echo "$f actualizada OK" | tee -a $logsi

	done

	popd > /dev/null

done