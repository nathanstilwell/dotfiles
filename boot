#!/bin/bash

DOTS=$HOME/.dotfiles;

source "$DOTS/utils/colors.sh";


echo "Pretend this is into with instructions ...";

read -p "Are you ready to proceed? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  . ./setup
fi


read -p "Do you want to set up your shell? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  . ./shell_setup
fi

read -p "Do you want to install mac stuff? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo "run mac_defaults here"
fi

