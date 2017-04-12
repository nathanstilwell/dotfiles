#!/usr/bin/env zsh
# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

export THEME="ace-of-spades"

# Set Homebrew cask to install to /Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"


# Load Oh-my-zsh
source "$ZSH/oh-my-zsh.sh"

#
# Load Aliases from Home Directory
#
if [ -f ~/.zsh_aliases ]; then
  . ~/.zsh_aliases
fi

# load antigen
# source /usr/local/share/antigen/antigen.zsh;
# antigen bundle zsh-users/zsh-syntax-highlighting
# antigen bundle zsh-users/zsh-autosuggestions
# antigen apply
