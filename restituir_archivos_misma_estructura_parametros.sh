#!/bin/bash

fuente=$1
destino=$2
archivo=$3

namefuente=${fuente::-1};
namedestino=${destino::-1};


for f in $( find $fuente -type f -name $archivo ); do

  nuevo=${f/$namefuente/$namedestino}

  mv -fv $f $nuevo

done

