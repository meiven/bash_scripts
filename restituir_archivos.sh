#!/bin/bash

orig="pdfs/"
dest="libro/"

for f in $( find $dest -name "*.pdf" ); do

	echo ""

	name=$(basename "$f")

	cantidad_dest=$( find $dest -name "$name" | wc -l)

	if [[ $cantidad_dest -gt 1 ]]; then
		echo "RRRR hay $cantidad_dest archivos llamados $name en el destino"
		for ff in $( find $dest -name "$name" ); do
			echo $ff
		done
  	else
  		echo "$f se puede copiar"
		cantidad_orig=$( find $orig -name "$name" | wc -l)

		if [[ $cantidad_orig -eq 0 ]]; then
			echo "XXXX no hay ningún archivo llamado $name en el origen"
		elif [[ $cantidad_orig -gt 1 ]]; then
			echo "RRRR pero hay $cantidad_orig archivos llamados $name en el origen.."
	  	else
	  		echo "OOOO se puede copiar!"
	  		#mv -fv "$g" "$f"
	  	fi
  	fi

  	#nuevo=${f/orig/redu}
	#ls -s $f
	#ls -s $nuevo
	#mv -fv $f $nuevo
	
done

