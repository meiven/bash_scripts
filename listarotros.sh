#!/bin/bash

find -mindepth 2 -type f ! -name "*.js" ! -name "*.css" ! -name "*.mp4" ! -name "*.ogv" ! -name "*.mp3" ! -name "*.ogg" ! -name "*.jpg" ! -name "*.png" ! -name "*.html" ! -name "*.xml" ! -name "*.json" ! -name "*.pdf" -printf "%k KB\t%p\n" | sort -nr
