#!/bin/bash


parametro_titulo="titulo"  # valores posibles: "enunciado", "titulo"

salida="tor_"$parametro_titulo".csv"
> $salida

echo "[ruta];Página;Tipo recurso;Titulo;Descripción;POSX;POSY;URL o path y nombre del archivo;Perfil" >> $salida

#echo -e "\nborrando zips del primer nivel ..."
#find -maxdepht 1 -name "*.zip" -exec rm -v {} \;

#echo -e "\nsubiendo zips al primer nivel y creando archivo $salida ..."

for f in $( find -mindepth 2 -name "*.zip" ); do

	echo ""
	nombre=$(basename $f)
	carpeta=$(dirname $f)


	#SUBIENDO ZIPS AL PRIMER NIVEL

	#comprueba que solo haya un zip con el mismo nombre, si hay mas de uno lo renombra usando su ruta
	cantidadzips=$( find -mindepth 2 -name "$nombre" | wc -l)

	if [[ $cantidadzips -gt 1 ]]; then	
		echo ""
		echo "hay $cantidad archivos $nombre"
		find -mindepth 2 -name $nombre
		nombre="${f//\//__}"
		nombre=${nombre:1}
		echo $nombre
	fi


	#CREANDO ARCHIVO TOR

	existedata0=0
	existedatajson=0

	#busca xml o json para sacar el titulo de la actividad
	existedata0=$( find $carpeta -maxdepth 1 -name "data0.xml" | wc -l)
	existedatajson=$( find $carpeta -maxdepth 2 -name "data.json" | wc -l)

	echo "--- carpeta:" $carpeta "---"
	
	echo "existedata0:" $existedata0
	echo "existedatajson:" $existedatajson

	#saca el titulo de data0.xml
	if [[ $existedata0 -eq 1 ]]; then

		data0=$( find $carpeta -maxdepth 1 -name "data0.xml")


		titulo=$(grep "<titulo>" $data0)
		cierretitulo=$(echo $titulo | grep  "</titulo>" | wc -l)

		if [[ cierretitulo -gt 0 ]]; then
			titulo=$( echo "$titulo" | grep -o -P '(?<=titulo>).*(?=</titulo)' )
		else
			titulo="${titulo//<titulo>/}"
		fi


		enunciado=$(grep "<enunciado>" $data0)
		cierreenunciado=$(echo $enunciado | grep  "</enunciado>" | wc -l)

		if [[ cierreenunciado -gt 0 ]]; then
			enunciado=$( echo "$enunciado" | grep -o -P '(?<=enunciado>).*(?=</enunciado)' )
		else
			enunciado="${enunciado//<enunciado>/}"
		fi
		enunciado="${enunciado//\\t/}"


		texto=$(grep "<texto>" $data0)
		cierretexto=$(echo $texto | grep  "</texto>" | wc -l)

		if [[ cierretexto -gt 0 ]]; then
			texto=$( echo "$texto" | grep -o -P '(?<=texto>).*(?=</texto)' )
		else
			texto="${texto//<texto>/}"
		fi


		existetitulo=$(grep "<titulo>" $data0 | wc -l)
		existeenunciado=$(grep "<enunciado>" $data0 | wc -l)
		existetexto=$(grep "<texto>" $data0 | wc -l)

		existetituloc=$(grep "<titulo>" $data0 | wc -c)
		existeenunciadoc=$(grep "<enunciado>" $data0 | wc -c)
		existetextoc=$(grep "<texto>" $data0 | wc -c)

		existetitulow=$(grep "<titulo>" $data0 | wc -w)
		existeenunciadow=$(grep "<enunciado>" $data0 | wc -w)
		existetextow=$(grep "<texto>" $data0 | wc -w)

		echo "existetitulo:" $existetitulo "-" $titulo
		echo "existeenunciado:" $existeenunciado "-" $enunciado
		echo "existetexto:" $existetexto "-" $texto

		echo "existetitulow:" $existetitulow
		echo "existeenunciadow:" $existeenunciadow
		echo "existetextow:" $existetextow

		echo "existetituloc:" $existetituloc
		echo "existeenunciadoc:" $existeenunciadoc
		echo "existetextoc:" $existetextoc


		if [[ $parametro_titulo == "titulo" && $existetitulow -gt 1 ]]; then
			campotitulo=$titulo
		else
			campotitulo=$enunciado
		fi

		if [[ $parametro_titulo == "enunciado" && $existeenunciadow -gt 1 ]]; then
			campotitulo=$enunciado
		else
			campotitulo=$titulo
		fi

		if [[ $existetitulow -lt 2 && $existeenunciadow -lt 2 ]]; then
			if [[ $existetexto == 1 ]]; then
				campotitulo=$texto
			else
				campotitulo="/t/t[XXXXX-- no hay etiqueta titulo, enunciado ni texto en el data0.xml --XXXXX]"
			fi
		fi

	#saca el titulo de data.json
	elif [[ $existedatajson -eq 1 ]]; then

		datajson=$( find $carpeta -maxdepth 2 -name "data.json")

		existetitulo=$(grep '"activityTitle":' $datajson | wc -l)
		lineatitulo=$(grep '"activityTitle":' $datajson)
		titulo=$( echo "$lineatitulo" | grep -o -P '(?<="activityTitle":).*(?=",)' )

		existeenunciado=$(grep '"enunciado":' $datajson | wc -l)
		lineaenunciado=$(grep '"enunciado":' $datajson)
		enunciado=$( echo "$lineaenunciado" | grep -o -P '(?<="enunciado":).*(?=",)' )


		if [[ $parametro_titulo == "titulo" && $existetitulo == 1 ]]; then
			campotitulo=$titulo
		else
			campotitulo=$enunciado
		fi

		if [[ $parametro_titulo == "enunciado" && $existeenunciado == 1 ]]; then
			campotitulo=$enunciado
			echo "existeenunciado:" $existeenunciado
		else
			campotitulo=$titulo
		fi



	#no existe data0 ni data.json
	else
		campotitulo="[XXXXX-- no existe data0.xml ni data.json --XXXXX]"
	fi


	campotitulo="${campotitulo//;/,}"
	
	campotitulo="${campotitulo//\\r\\n/}"
	campotitulo="${campotitulo//\\r/}"
	campotitulo="${campotitulo//\\n/}"

	campotitulo="${campotitulo//\/r\/n/}"
	campotitulo="${campotitulo//\/r/}"
	campotitulo="${campotitulo//\/n/}"

	echo $campotitulo
	echo "$carpeta;;zip;$campotitulo;;;;$nombre;" >> $salida

done

#find -mindepth 2 -name "*.zip" -exec rm {} \;
