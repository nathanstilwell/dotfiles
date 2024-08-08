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
#   Favorite fonts:
#     - 3d
#     - bloody
#     - halfiwi
#
function fig --description="Figlet with custom fonts" --argument font text
  figlet -d ~/.local/share/figlet/fonts -w 120 -f $font -l $text
end

function shofig --description="Show choice figlet fonts"
  showfigfonts -d "$HOME/.dotfiles/figlet/fonts/"
end
