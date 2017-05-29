#!/bin/bash

fuente=orig/
destino=redu/


for f in $( find "$fuente" -type f -name "*.png" ); do

  nuevo=${f/orig/redu}

  #ls -s $f
  #ls -s $nuevo

  mv -fv $f $nuevo

done

