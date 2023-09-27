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

function _f --description "Output text in figlet with my 'default' font"
  command -v figlet > /dev/null && figlet -f bloody -w 120 -c "$1" | pbcopy
end

function _r --description "Output text in figlet roman"
  command -v figlet > /dev/null && figlet -f roman -w 120 -c "$1" | pbcopy
end

function _3 --description "Output text in figlet 3d"
  command -v figlet > /dev/null && figlet -f 3d "$1";
end

function fig --description "A shortcut for figlet with width preset to 120"
  command -v figlet > /dev/null && figlet -f "$1" -w 120 -c "$2" | pbcopy;
end
