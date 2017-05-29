#!/bin/bash

echo "borrando archivos ocultos... "

find -mindepth 2 -depth -name ".*" -exec rm -fRv {} \;

