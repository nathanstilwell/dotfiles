#                                 .o.       oooo   o8o
#                                .888.      `888   `"'
#                               .8"888.      888  oooo   .oooo.    .oooo.o  .ooooo.   .oooo.o
#                              .8' `888.     888  `888  `P  )88b  d88(  "8 d88' `88b d88(  "8
#                             .88ooo8888.    888   888   .oP"888  `"Y88b.  888ooo888 `"Y88b.
#                            .8'     `888.   888   888  d8(  888  o.  )88b 888    .o o.  )88b
#                           o88o     o8888o o888o o888o `Y888""8o 8""888P' `Y8bod8P' 8""888P'

## Alphabet
abbr @ sudo
abbr _ bat
abbr b brew
abbr c curl
abbr d docker
abbr e  echo
abbr g  git
abbr h  heroku
abbr k  ksdiff
abbr m  make
abbr n  npm
abbr o  open
abbr v  vim
abbr r  rbenv
abbr t  tree
abbr y  yarn

alias f="find . | fzf"
alias p="python -m SimpleHTTPServer"
alias s="screen -DRU"
alias x="rm -rfP"

# Applications
alias mkd="open -a /Applications/Marked\ 2.app"
command -v hub > /dev/null && alias git="hub"

# Directories
alias l="ls -lp"
alias ll="ls -alhF"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias copy="pbcopy"
alias md="mkdir -p"
alias rd="rmdir"
alias here="pwd | pbcopy"

## Drives
alias unmount='diskutil eject'
alias eject='diskutil eject'

## system
alias load="source ~/.config/fish/config.fish";

## edit dotfiles
alias dots='vim ~/.dotfiles'