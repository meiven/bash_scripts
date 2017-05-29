#!/bin/bash

for f in $( find -name "*.png" -size +1400k ); do

	eog $f

done
