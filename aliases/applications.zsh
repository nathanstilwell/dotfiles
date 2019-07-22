#                     ██                      ██ ██                     ██   ██
#                    ████    ██████  ██████  ░██░░                     ░██  ░░
#                   ██░░██  ░██░░░██░██░░░██ ░██ ██  █████   ██████   ██████ ██  ██████  ███████   ██████
#                  ██  ░░██ ░██  ░██░██  ░██ ░██░██ ██░░░██ ░░░░░░██ ░░░██░ ░██ ██░░░░██░░██░░░██ ██░░░░
#                 ██████████░██████ ░██████  ░██░██░██  ░░   ███████   ░██  ░██░██   ░██ ░██  ░██░░█████
#                ░██░░░░░░██░██░░░  ░██░░░   ░██░██░██   ██ ██░░░░██   ░██  ░██░██   ░██ ░██  ░██ ░░░░░██
#                ░██     ░██░██     ░██      ███░██░░█████ ░░████████  ░░██ ░██░░██████  ███  ░██ ██████
#                ░░      ░░ ░░      ░░      ░░░ ░░  ░░░░░   ░░░░░░░░    ░░  ░░  ░░░░░░  ░░░   ░░ ░░░░░░


alias mkd='open -a /Applications/Marked\ 2.app'
command -v hub > /dev/null && alias git='hub'
alias typ='typings'
alias ng='ngrok'

# Vim edit diff from master
alias fulldiff='git diff origin/master...HEAD'
alias vimall='vim `fulldiff --name-only`'

# Atom edit fulldiff
alias atomall='atom `fulldiff --name-only`'

# list all dirty files in a git repo
alias all-dirty-files="git status --porcelain | awk '{print \$2}'"

# edit all dirty files
alias atomdirty='atom `all-dirty-files`'

command -v keybase > /dev/null && {
  alias kb='keybase'
}
