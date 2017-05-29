#!/bin/bash

find . -mindepth 2 -name "*.mp4" -print -exec ffmpeg -y -i {} -c:v libx264 -b:v 260k -c:a aac -b:a 64k -strict -2 bkp.mp4 \; -exec mv -fv bkp.mp4 {} \;

