#!/bin/bash

smbclient //almacen-digital-1/anayaeducacion -U educacion%buz-edu7924 -c "mkdir $1; cd $1; prompt; recurse; mput *;"

url="http://www.edistribucion.int/anayaeducacion/"$1"/index.html"

firefox $url