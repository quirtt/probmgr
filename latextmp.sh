#!/bin/bash

# Having $HOME/Documents/OTIS/texfiles directory is mandatory.

mode=$1
texname=$2
name=${texname%.tex}
group=$HOME/Projects/probmgr/group.sh

if [ $mode = "open" ];
then
# Example command would be 
# latextmp open 13SLA4.tex 
# in $HOME/Documents/OTIS/texfiles/13SLA4
  mkdir /tmp/latex/
  mkdir /tmp/latex/$name/
  FILE=/tmp/latex/$name/$name.tex
  if [ -f "$FILE" ];
  then
    echo "$FILE exists."
  else
    cp $name.tex /tmp/latex/$name/$name.tex
  fi
  cd /tmp/latex/$name/
  subl /tmp/latex/$name/$name.tex 
  latexmk -pvc -pdf -interaction=nonstopmode $name.tex 1> /dev/null
  cd $HOME/Documents/OTIS/texfiles/$name
elif [ $mode = "clean" ];
then
  read -p "Are you sure you wanna delete? [y/N] " delete
  if [ $delete = "y" ];
  then 
    cd $HOME/Documents/OTIS/texfiles/$name
    mv /tmp/latex/$name/$name.tex .
    mv /tmp/latex/$name/$name.pdf .
    rm -rf /tmp/latex/$name
    echo "Cleaned..."
  else
  echo "Think again."
  fi
elif [ $mode = "new" ];
then
  ## There is no tex in name here
  FILE2=$HOME/Documents/OTIS/texfiles/$name/$name.tex
  if [ -f "$FILE2" ];
  then
    echo "$FILE2 already exists."
  else
    mkdir $HOME/Documents/OTIS/texfiles/$name
    touch $HOME/Documents/OTIS/texfiles/$name/$name.tex
    cd $HOME/Documents/OTIS/texfiles/$name
    bash $HOME/Projects/probmgr/latextmp.sh open $name.tex
  fi
# grouping texfiles into handout!
elif [ $mode = "group" ];
then
 # example: latextmp group group.txt dnw-vp.tex
 FILE3=$2
 read -p "source file: " src
 while [ -s $FILE3 ];
 do
   bash $group $(sed 1q $FILE3) $src
   sed -i '1d' $FILE3
 done
else
  echo "Only open, clean, new, group modes exist."
fi
