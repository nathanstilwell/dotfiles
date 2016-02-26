#!/usr/bin/env bash
DOTS=~/.dotfiles;

# source files
for file in $DOTS/source/*; do
  [ -e "$file" ] && source "$file"
done
unset file

# prompt

## load up git prompt functions

source $DOTS/lib/git_prompt.sh;

MACHINENAME="\[$ecru$bold\]\\H\[$stop\]";
DIRNAME="\[$cyan\][\\w]\[$stop\]";

export PS1="$MACHINENAME in $DIRNAME\$(git_prompt)
> ";

#
# Load System Specific Aliases
#
if [ -f ~/.profile ]; then
  . ~/.profile
fi
