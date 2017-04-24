#!/bin/bash

##
##    Figlet
##

function __ () {
  command -v figlet && figlet -f larry3d -w 120 -c "$1" | pbcopy
}

function _r () {
  command -v figlet && figlet -f roman -w 120 -c "$1" | pbcopy
}

function fig () {
  command -v figlet && figlet -f "$1" -w 120 -c "$2" | pbcopy;
}

function shrug {
   echo "¯\_(ツ)_/¯" | pbcopy;
}

function table {
echo " (╯°□°）╯︵ ┻━┻" | pbcopy;
}

##
##    Apps
##

function atom-save {
  if [[ -e ~/.atom && -e ~/.atom/bin ]]; then
    ~/.atom/bin/save-packages;
  else
    echo "Atom editor not installed";
  fi
}

function atom-install {
  if [[ -e ~/.atom && -e ~/.atom/bin ]]; then
    ~/.atom/bin/install-packages;
  else
    echo "Atom editor not installed";
  fi
}

##
##    Utils
##

function take() {
  mkdir -p $1
  cd $1
}

function c () {
  cd "$1" || exit;
  l;
}

function getip {
  ifconfig en0 | grep -w 'inet' | awk '{print $2}';
}

function untar {
  if [ -n "$2" ]; then
    echo "creating dir $2";
    mkdir "$2";
    echo "extracting";
    tar -C "$2" -zxvf "$1";
    return;
  fi

  tar -zxvf "$1";
}

function profile {
  for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done;
}

function stats() {
  history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}
