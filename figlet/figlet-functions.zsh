##
##      ████████ ██          ██           ██
##      ░██░░░░░ ░░   █████  ░██          ░██
##      ░██       ██ ██░░░██ ░██  █████  ██████
##      ░███████ ░██░██  ░██ ░██ ██░░░██░░░██░
##      ░██░░░░  ░██░░██████ ░██░███████  ░██
##      ░██      ░██ ░░░░░██ ░██░██░░░░   ░██
##      ░██      ░██  █████  ███░░██████  ░░██
##      ░░       ░░  ░░░░░  ░░░  ░░░░░░    ░░
##

function __ () {
  command -v figlet > /dev/null && figlet -f larry3d -w 120 -c "$1" | pbcopy
}

function _r () {
  command -v figlet > /dev/null && figlet -f roman -w 120 -c "$1" | pbcopy
}

function _3 () {
  command -v figlet > /dev/null && figlet -f 3d "$1";
}

function fig () {
  command -v figlet > /dev/null && figlet -f "$1" -w 120 -c "$2" | pbcopy;
}
