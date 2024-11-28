#!/bin/bash

DOTS=$HOME/.dotfiles;

source "$DOTS/utils/colors.sh";


echo "Pretend this is into with instructions ...";

echo
echo
read -p "Are you ready to proceed? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  . $DOTS/setup
fi

command -v fish &>/dev/null || {
  echo -e ${red:?}Fish not found${stop:?};
  exit 1;
}

echo
echo
read -p "Do you want to set up your shell? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  command -v fish > /dev/null && {
    fish $DOTS/shell_setup
  }
fi

echo
echo
read -p "Do you want to install applications? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  command -v fish > /dev/null && {
    fish $DOTS/app_install
  }
fi

echo
echo
read -p "Do you want to install mac stuff? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  command -v fish > /dev/null && {
    fish $DOTS/set_defaults
  }
fi

