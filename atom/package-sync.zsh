##
##          ██       ██
##         ████     ░██
##        ██░░██   ██████  ██████  ██████████
##       ██  ░░██ ░░░██░  ██░░░░██░░██░░██░░██
##      ██████████  ░██  ░██   ░██ ░██ ░██ ░██
##     ░██░░░░░░██  ░██  ░██   ░██ ░██ ░██ ░██
##     ░██     ░██  ░░██ ░░██████  ███ ░██ ░██
##     ░░      ░░    ░░   ░░░░░░  ░░░  ░░  ░░

function atom-save {
  if [[ -e ~/.atom && -e ~/.atom/bin ]]; then
    ~/.atom/bin/save-packages;
  else
    echo "Atom editor not installed";
  fi
}

function atom-install {
  if [[ -e ~/.atom && -e ~/.atom/bin ]]; then
    ~/.atom/bin/install-packages;
  else
    echo "Atom editor not installed";
  fi
}
