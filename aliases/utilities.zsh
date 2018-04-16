#                                  ██     ██   ██   ██  ██ ██   ██   ██
#                                 ░██    ░██  ░██  ░░  ░██░░   ░██  ░░
#                                 ░██    ░██ ██████ ██ ░██ ██ ██████ ██  █████   ██████
#                                 ░██    ░██░░░██░ ░██ ░██░██░░░██░ ░██ ██░░░██ ██░░░░
#                                 ░██    ░██  ░██  ░██ ░██░██  ░██  ░██░███████░░█████
#                                 ░██    ░██  ░██  ░██ ░██░██  ░██  ░██░██░░░░  ░░░░░██
#                                 ░░███████   ░░██ ░██ ███░██  ░░██ ░██░░██████ ██████
#                                  ░░░░░░░     ░░  ░░ ░░░ ░░    ░░  ░░  ░░░░░░ ░░░░░░


## Drives
alias unmount='diskutil eject'
alias eject='diskutil eject'

## system
alias load='source ~/.zshrc'
alias _='sudo'
alias history='fc -l 1'

## edit dotfiles
alias dots='vim ~/.dotfiles'

## Check HTTP status codes (with cats)
function whatcat {
  if [ -z "$1" ]; then
cat <<-USAGE
  usage: whatcat <http status code>
USAGE
  else
    open "https://http.cat/$1";
  fi
}
