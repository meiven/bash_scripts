#!/bin/bash

echo "borrando archivos ... "

find -regex ".*\.\(tiff\|tif\|psd\|indd\|fla\|zip\|mov\|docx\|ppt\|pptx\|ogv\|ogg\|wav\|PSD\)" -exec rm -fv {} \;

find -name "Thumbs.db" -exec rm -fv {} \;

find -name "__MACOSX" -exec rm -rfv {} \;

find -name "*DS_Store" -exec rm -fv {} \;
