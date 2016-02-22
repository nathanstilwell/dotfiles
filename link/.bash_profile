#!/bin/bash
DOTS=~/.dotfiles;

# prompt
# For more colors : http://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/
export PS1="\[\e[0;31m\\H\e[m in \e[0;36m[\\w]\e[m>\]"

# source files
for file in $DOTS/source/*; do
  [ -e "$file" ] && source "$file"
done
unset file

#
# Load System Specific Aliases
#
if [ -f ~/.profile ]; then
  . ~/.profile
fi
