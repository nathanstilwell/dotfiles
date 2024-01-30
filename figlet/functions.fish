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

#
#   Examples of figlet usage:
#
#   // use "bloody" font at 120 char wide centered
#   figlet -f bloody -w 120 -c [text]
#   // use "roman" font at 120 char wide centered
#   figlet -f roman -w 120 -c [text]
#   // use "3d" font
#   figlet -f 3d [text];
#
function fig --description="Figlet with custom fonts" --argument font text
  figlet -d ~/.local/share/figlet/fonts -w 120 -f $font -c $text
end
