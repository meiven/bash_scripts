#!/bin/bash

for f in $( find -mindepth 2 -type f -name "*.mp4" ); do

  echo "$f"
  rm -f "$f"
  cp video.mp4 "$f"

done
