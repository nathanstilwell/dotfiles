#!/bin/bash
DOTS=~/.dotfiles;

# source files
for file in $DOTS/source/*; do
  [ -e "$file" ] && source "$file"
done
unset file

# prompt

MACHINENAME="\[$ecru$bold\]\\H\[$stop\]";
DIRNAME="\[$cyan\][\\w]\[$stop\]";

export PS1="$MACHINENAME in $DIRNAME> ";

#
# Load System Specific Aliases
#
if [ -f ~/.profile ]; then
  . ~/.profile
fi
