#!/bin/bash

# find -mindepth 2 -type f ! -name "*.js" ! -name "*.css" ! -name "*.mp4" ! -name "*.ogv" ! -name "*.mp3" ! -name "*.ogg" ! -name "*.jpg" ! -name "*.png" ! -name "*.html" ! -name "*.xml" ! -name "*.json" ! -name "*.pdf" ! -name -printf "%k KB\t%p\n" | sort -nr

find -mindepth 2 ! -regex ".*\.\(js\|css\|html\|xml\|json\|mp4\|mp3\|ogg\|jpg\|png\|pdf\|eot\|woff\|ttf\|svg\)" -name "*.*" -printf "%k KB\t%p\n" | sort -nr