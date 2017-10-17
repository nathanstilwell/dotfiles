#!/bin/bash

function shrug {
   echo "¯\_(ツ)_/¯" | pbcopy;
}

function table {
echo " (╯°□°）╯︵ ┻━┻" | pbcopy;
}

##
##    Utils
##

function take() {
  mkdir -p $1
  cd $1
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

function randomSha {
  head -n 4096 /dev/urandom | openssl sha | xargs echo -n | pbcopy;
}
