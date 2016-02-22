#!/bin/bash
DOTS=~/.dotfiles;

# prompt
# For more colors : http://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/
export PS1="\[\033[0;31m\] \\H \[\033[m\] in \[\033[0;36m\] [\\w] \[\033[m\]> "

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
