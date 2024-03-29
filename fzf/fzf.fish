
#   ██   ██                  ██████   ██               ██
#  ░██  ██           ██   ██░█░░░░██ ░░               ░██
#  ░██ ██    █████  ░░██ ██ ░█   ░██  ██ ███████      ░██  ██████
#  ░████    ██░░░██  ░░███  ░██████  ░██░░██░░░██  ██████ ██░░░░
#  ░██░██  ░███████   ░██   ░█░░░░ ██░██ ░██  ░██ ██░░░██░░█████
#  ░██░░██ ░██░░░░    ██    ░█    ░██░██ ░██  ░██░██  ░██ ░░░░░██
#  ░██ ░░██░░██████  ██     ░███████ ░██ ███  ░██░░██████ ██████
#  ░░   ░░  ░░░░░░  ░░      ░░░░░░░  ░░ ░░░   ░░  ░░░░░░ ░░░░░░

#
# Ctrl+T -- search directory
# Ctrl+G -- search git log
# Ctrl+S -- search git status
# Ctrl+R -- search history
# Ctrl+P -- search processess
# Ctrl+N -- search npm lifecycle scripts
#

# capture unbound keys -- see https://fishshell.com/docs/current/cmds/bind.html
bind '' self-insert

# Configure key bindings for patrickf1/fzf.fish
fzf_configure_bindings --directory=\ct --git_log=\cg --git_status=\cs --history=\cr --processes=\cp

# Npm life cycle scripts bound to Ctrl+N. see npm/functions.fish