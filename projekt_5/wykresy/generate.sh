#!/bin/bash

bash clear.sh

for f in `ls | grep tex`
do
	pdflatex --shell-escape $f
done

bash clear.sh
