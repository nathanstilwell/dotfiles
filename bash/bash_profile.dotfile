#!/usr/bin/env bash
DOTS=~/.dotfiles;

# source files
for file in $DOTS/source/*; do
  # shellcheck source=/dev/null
  [ -e "$file" ] && source "$file"
done
unset file

# prompt

## load up git prompt functions

# shellcheck source=$DOTS/lib/git_prompt.sh
source $DOTS/lib/git_prompt.sh;

MACHINENAME="\[$ecru$bold\]\\H\[$stop\]";
DIRNAME="\[$cyan\][\\w]\[$stop\]";

export PS1="$MACHINENAME in $DIRNAME\$(git_prompt)
> ";

#
# Load System Specific Aliases
#
if [ -f ~/.profile ]; then
  # shellcheck source=/dev/null
  . ~/.profile
fi
