#!/bin/bash

# use script only in $HOME/Documents/OTIS/texfiles/{Whichever Problem You Are Solving}
# Example command would be 
# latextmp open 13SLA4.tex 
# in $HOME/Documents/OTIS/texfiles/13SLA4

mode=$1
texname=$2
name=${texname%.tex}

if [ $mode = "open" ];
then
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
  fi
else
  echo "Only open, clean modes exist."
fi
