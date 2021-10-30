#!/bin/bash
# Support file for group mode of latextmp.sh

## IMPORTANT
# problem files should follow /group/prob_TMPL.tex 
# source files should follow /group/group_TMPL.tex
##

# If using separately then 
# example command: group.sh 19USATST07.tex 5 3 equality-dcw.tex
# where it is a 5 pointer and problem number 3rd

# input without .tex

inputname=$1
points=$2
prbnum=$3
src=$4

#remove last line from src
sed -i -e :a -e '$d;N;2,1ba' -e 'P;D' $src

# add \otisproblem{Points}{Problem Number}{Name} in src
echo "\otisproblem{$points}{$prbnum}{$inputname}" >> $src

#command to remove first 14 lines and the last line and piping it to src
sed -e :a -e '1,14d;$d;N;2,1ba' -e 'P;D' $OTIS/texfiles/$inputname/$inputname.tex >> $src 

# add last line in srcfile
echo "
\end{document}" >> $src
