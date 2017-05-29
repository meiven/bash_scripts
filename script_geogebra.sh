#!/bin/bash

for f in $( find -name "*.html" ); do

	name=$(basename $f)
	dir=$(dirname $f)
	directdir=$(basename $dir)

	echo "----"
	echo $f
	echo $directdir

	unidad="${directdir:0:3}"
	echo $unidad
	newname=$unidad"_"$name

	echo $newname

	name="${name//x.html/}"
	name="${name// /}"

	echo $f


	mkdir $newname

	target="$newname""/index.html"

	cp $f $target

	sname="${name:2}"

	mkdir $newname"/js/"
	mkdir $newname"/images/"

	sourc="$dir""/js/"
	sourc2="$dir""/images/"

	cp -R $sourc $newname
	cp -R $sourc2 $newname

done