#!/bin/bash
SAVEIFS=IFS
IFS=$(echo -en "\n\b")

find archivos -type f -name 'cedula_dorso*.pdf' -print0 | while IFS= read -r -d '' archivo; do
  rm tmp.png
  cedula=$(basename ${archivo})
  dibujo=$(echo "${cedula}" | sed 's/cedula_dorso_//')
  convert -density 100 "archivos/${dibujo}" -crop +0-290 -crop +0+270 tmp.png 
  convert -density 200 "archivos/${cedula}" \( tmp.png  -resize 1100x \) \
        -gravity North -geometry +0+160 -composite "resultado/Cedula dorso ${dibujo}"
IFS=$SAVEIFS
done

