#!/bin/bash


if [ ! -d "zfiles" ]; then
	echo "*** Falta la carpeta 'zfiles'"
	exit 
fi


echo "Actualizando todos los archivos scorm.js, scromdriver.js, KitabooCommunicationManager.js, script.js, audio_control.js, functions_drag.js, act_text_area.js y jquery.control.js ..."

# ACTUALIZAR ARCHIVOS

echo -e "\nActualizando archivos function_drag.js (añadiendo gestionarSCO) ..."

for objetivo in $( find -mindepth 2 -type f -name "functions_drag.js" ); do


	echo $objetivo
	
	sed -e '0,/alert("BIEN TERMINADA EN "+sum+" MOVIMIENTOS");/{s/alert("BIEN TERMINADA EN "+sum+" MOVIMIENTOS");/alert("BIEN TERMINADA EN "+sum+" MOVIMIENTOS");\n\t\tif (Scorm_conectado()){gestionarSCO(1, 1, 1);}/}' -e '0,/alert("MAL TERMINADA EN "+sum+" MOVIMIENTOS");/{s/alert("MAL TERMINADA EN "+sum+" MOVIMIENTOS");/alert("MAL TERMINADA EN "+sum+" MOVIMIENTOS");\n\t\tif (Scorm_conectado()){gestionarSCO(1, 1, 0);}/}' $objetivo > functions_drag.js 


	dirobjetivo="$(dirname "$objetivo")"
	rm -rf "$objetivo"
	mv -fv functions_drag.js "$dirobjetivo"  

done
	


echo -e "\nActualizando archivos script.js (añadiendo comunicación a Kitaboo para ejercicios de respuesta libre) ..."

for objetivo in $( find -mindepth 2 -type f -name "script.js" ); do

	echo $objetivo
	
	sed -e "s/Scorm_start();//" -e "s/return res;/var result = ( isNaN(this.porcentajeA) ) ? 100 : this.porcentajeA;\n\t\t\ttry{\n\t\t\t\tKitabooCommunicationManager.sendActivityData(result, res, this.total);\n\t\t\t\tif (window.console) console.log('Mandando información a Kitaboo!');\n\t\t\t}catch(err){\n\t\t\t\tif (window.console) console.log('No se puede mandar la información a Kitaboo...');\n\t\t\t}\n\t\t\treturn res;/" $objetivo > script.js 

	dirobjetivo="$(dirname "$objetivo")"
	rm -rf "$objetivo"
	mv -fv script.js "$dirobjetivo"  

done



for f in $( find -name "datos" -type d ); do

	echo ""

	folder=$(dirname "$f")
	echo $folder

	algunxml=$( find $folder -maxdepth 1 -name "data0.xml" | wc -l)
	echo $algunxml

	if [ $algunxml -eq 0 ]; then

		for j in $(find $folder -name "jquery.control.js"); do

			echo $j

			sed 's/if(currentIndex != pantallas)/if(false)/' $j > jquery.control.js 
			sed 's/if(currentIndex!=pantallas)/if(false)/' $j > jquery.control.js 

			dirobjetivo="$(dirname "$j")"
			rm -rf "$j"
			mv -fv jquery.control.js "$j"  

		done
	fi

done


for f in $(find -name "data0.xml" ); do

	folder=$(dirname $f)

	for j in $(find $folder -name "jquery.control.js" -exec grep -l "if(false)" {} \;); do

		((cont_cambiadas++))
		echo $j | tee -a "log_fixed_if_false.log"

		sed 's/if(false)/if(currentIndex != pantallas)/' $j > jquery.control.js 

		dirobjetivo="$(dirname "$j")"
		rm -rf "$j"
		mv -fv jquery.control.js "$j"  

	done

done



echo -e "\nActualizando archivos act_text_area.js (eliminando botones 'Enviar respuestas') ..."

for objetivo in $( find -mindepth 2 -type f -name "act_text_area.js" ); do

	echo $objetivo
	
	sed -e "s/res += '<li class=\"\"><button id=\"boton_email\" type=\"submit\" value=\"text\">Enviar Respuestas<\/button><\/li>';/\/\/res += '<li class=\"\"><button id=\"boton_email\" type=\"submit\" value=\"text\">Enviar Respuestas<\/button><\/li>';/" -e "s/res += '<li class=\"rLibre\">'+correo+'<\/li>';/\/\/res += '<li class=\"rLibre\">'+correo+'<\/li>';/" -e "s/jQuery('<button id=\"responder\" type=\"button\">Guarda tu respuesta<\/button>').appendTo(\"#text\");/\/\/jQuery('<button id=\"responder\" type=\"button\">Guarda tu respuesta<\/button>').appendTo(\"#text\");/" -e "s/return res;/try{\n\t\t\t\tKitabooCommunicationManager.sendActivityData(100, res, 1);\n\t\t\t\tif (window.console) console.log('Mandando información a Kitaboo!');\n\t\t\t}catch(err){\n\t\t\t\tif (window.console) console.log('No se puede mandar la información a Kitaboo...');\n\t\t\t}\n\t\t\treturn res;/" $objetivo > act_text_area.js 

	dirobjetivo="$(dirname "$objetivo")"
	rm -rf "$objetivo"
	mv -fv act_text_area.js "$dirobjetivo"  

done



echo -e "\nActualizando archivos audio_control.js (eliminando salida de mensajes por consola) ..."

for objetivo in $( find -mindepth 2 -name "audio_control.js" ); do

	echo $objetivo

	nombre=$(basename $objetivo)
	
	sed 's/console.log("soy menorrrr");/\/\/console.log("soy menorrrr");/' "$objetivo" > "$nombre" 

	dirobjetivo="$(dirname "$objetivo")"
	rm -rf "$objetivo"
	mv -fv "$nombre" "$dirobjetivo"  

done



echo -e "\nActualizando archivos .js (renombrando funciones 'Scorm_conectado')..."

for objetivo in $( find -mindepth 2 -name "*.js" ! -name "scorm.js" -exec grep -l "function Scorm_conectado()" {} \; ); do

	echo $objetivo

	nombre=$(basename $objetivo)
	
	sed 's/function Scorm_conectado()/function Scorm_conectado_OLD()/' "$objetivo" > "$nombre" 

	dirobjetivo="$(dirname "$objetivo")"
	rm -rf "$objetivo"
	mv -fv "$nombre" "$dirobjetivo"  

done



echo -e "\nActualizando archivos .js (sustituyendo 'Incorrrecto' por 'Incorrecto') ..."

for objetivo in $( find -mindepth 2 -name "*.js" -exec grep -l "Incorrrecto" {} \; ); do

	echo $objetivo

	nombre=$(basename $objetivo)
	
	sed 's/Incorrrecto/Incorrecto/' "$objetivo" > "$nombre" 

	dirobjetivo="$(dirname "$objetivo")"
	rm -rf "$objetivo"
	mv -fv "$nombre" "$dirobjetivo"  

done







