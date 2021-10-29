#!/bin/bash
#temporary file to code group.sh

# need a input file and a file to put it into
# remove first [14] lines and the last line from the inputfile and then pipe it to srcfile 
# v1: srcfile in the same directory and then copy it to the main directory?


# have to remove the last line from src cuz the last line is "\end{Document}"
# refer to group/group_TMPL.tex for template of srcfile AFTER REMOVE THE LAST LINE



#example command: group.sh 19USATST07.tex 5 3 equality-dcw.tex
# where it is a 5 pointer and problem number 3rd
# input without .tex for "easyness"
inputname=$1
points=$2
prbnum=$3
src=$4

#remove last line from srcfile
sed -i -e :a -e '$d;N;2,1ba' -e 'P;D' $src

# add \otisproblem wtv
echo "\otisproblem{$points}{$prbnum}{$inputname}" >> $src

#command to remove first 14 lines and the last line and piping it to src
  sed -e :a -e '1,14d;$d;N;2,1ba' -e 'P;D' $inputname.tex >> $src 

# add last line in srcfile
echo "\end{document}" >> $src
