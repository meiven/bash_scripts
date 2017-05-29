#!/bin/bash

### VARIABLES

bitrate=48k 		# (número'k') bitrate en Kb/s
frecuencia=44100	# (22000 / 44100 / 96000 / 128000 / ...) frecuencia en Hz

### SCRIPT

echo -e "\nreduciendo audios mp3 a bitrate $bitrate, frecuencia $frecuencia Hz..."
find -name "*.mp3" -exec ffmpeg -i {} -b:a $bitrate -ar $frecuencia -y bkp.mp3 \; -exec mv -fv bkp.mp3 {} \;
echo ""

# para crear ogg a partir de los mp3
# find -name "*.mp3" -exec ffmpeg -i {} -b:a $bitrate {} -y \; -exec ffmpeg -i {} -b:a $bitrate -copy {}\b\b\b\b.ogg -y \;  
