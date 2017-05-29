#!/bin/bash

for d in $( find -mindepth 2 -maxdepth 2 -type d | sort); do

	echo ""
	echo $d

		for f in $( find $d -name "data0.xml" ); do

			titulo=$(grep "<titulo>" $f)
			enunciado=$(grep "<enunciado>" $f)
			palabra=$(grep "<palabra>" $f)

			echo $titulo
			echo $enunciado
			echo $palabra

		done

		for f in $( find $d -name "data*.xml" ! -name "data0.xml" | sort); do

			enunciado=$(grep "<enunciado>" $f)
			palabra=$(grep "<palabra>" $f)

			echo $enunciado
			echo $palabra

		done

		for f in $( find $d -name "act_input_select.js" ); do

			problema1=$(grep '$("#elements h5").html(' $f)
			problema2=$(grep '$("#elements h5").append(' $f)
			echo $problema1$problema2

		done

done


#para el regexp ->   \.\/|</?titulo>|</?enunciado>|</?palabra>