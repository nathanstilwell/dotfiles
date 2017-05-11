#                      ______     __         __     ______     ______
#                     /\  __ \   /\ \       /\ \   /\  __ \   /\  ___\
#                     \ \  __ \  \ \ \____  \ \ \  \ \  __ \  \ \___  \
#                      \ \_\ \_\  \ \_____\  \ \_\  \ \_\ \_\  \/\_____\
#                       \/_/\/_/   \/_____/   \/_/   \/_/\/_/   \/_____/

# Directory list
alias l='ls -lp'
alias ll='ls -alhF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias f='find . | fzf'
alias dir='dirs -v | head -10'
alias copy='pbcopy'

# Applications
alias mkd='open -a /Applications/Marked\ 2.app'
command -v hub > /dev/null && alias git='hub'

## App Alphabet
alias a='apm'
alias b='brew'
alias d='docker'
# alias g='git'
# alias g='gcloud'
alias h='heroku'
alias k='ksdiff'
# alias k='kubectl'
alias m='make'
alias n='npm'
alias p='python -m SimpleHTTPServer'
alias v='vim'
alias r='rbenv'
alias s='screen -DRU'
alias y='yarn'

# Drives
alias unmount='diskutil eject'
alias eject='diskutil eject'

# Util
## system
alias load='source ~/.zshrc'
alias _='sudo'
alias history='fc -l 1'

# Vim Help
alias fulldiff='git diff origin/master...HEAD'
alias vimall='vim `fulldiff --name-only`'
