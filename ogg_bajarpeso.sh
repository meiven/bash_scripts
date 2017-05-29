#!/bin/bash

### VARIABLES

bitrate=64k 		# (número'k') bitrate en Kb/s
frecuencia=44100	# (22000 / 44100 / 96000 / 128000 / ...) frecuencia en Hz

### SCRIPT

echo -e "\nreduciendo audios ogg a bitrate $bitrate, frecuencia $frecuencia Hz..."
find -name "*.ogg" -exec ffmpeg -i {} -b:a 64k -ar 22000 -y bkp.ogg \; -exec mv -fv bkp.ogg {} \;
echo ""

