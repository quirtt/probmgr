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
elif [ $mode = "mark" ];
then
  # example: latextmp mark 13TSTST8 "nt,vp,primitive roots"
  FILE4=$HOME/Documents/OTIS/texfiles/cmpl.txt
  FILE5=$HOME/Documents/OTIS/texfiles/$name/$name.info
  if [ -f "$FILE5" ];
  then
    cat $FILE5
    read -p "comments/tag: " cmnts
    read -p "append(1) or new(2)? " choice
    if [ $choice = "1" ];
    then
      sed -i '${s/$/'"${cmnts}"'/}' $FILE5
      cat $FILE5
    elif [ $choice = "2" ];
    then
      echo "$cmnts" > $FILE5
      cat $FILE5
    else
      echo "Only append(1) and new(2) exists."
    fi
  else
    read -p "comments/tag: " cmnts
    touch $FILE5
    echo "$cmnts" > $FILE5 
  fi
elif [ $mode = "show" ];
then
  DRCT=$HOME/Documents/OTIS/texfiles/
  tree $DRCT | grep ".info"
else
  echo "This is not a valid mode."
fi
