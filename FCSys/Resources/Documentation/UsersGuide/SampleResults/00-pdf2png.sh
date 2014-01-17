#!/bin/bash
# Create PNG versions of the PDF images in this folder.
#
# Created by Kevin Davies, 10/19/2012

for fname in *.pdf
do
    convert -density 80 "$fname" "${fname%.pdf}.png"
done
