
#   ██   ██                  ██████   ██               ██
#  ░██  ██           ██   ██░█░░░░██ ░░               ░██
#  ░██ ██    █████  ░░██ ██ ░█   ░██  ██ ███████      ░██  ██████
#  ░████    ██░░░██  ░░███  ░██████  ░██░░██░░░██  ██████ ██░░░░
#  ░██░██  ░███████   ░██   ░█░░░░ ██░██ ░██  ░██ ██░░░██░░█████
#  ░██░░██ ░██░░░░    ██    ░█    ░██░██ ░██  ░██░██  ░██ ░░░░░██
#  ░██ ░░██░░██████  ██     ░███████ ░██ ███  ░██░░██████ ██████
#  ░░   ░░  ░░░░░░  ░░      ░░░░░░░  ░░ ░░░   ░░  ░░░░░░ ░░░░░░

#
# Ctrl+t -- search directory
# Ctrl+g -- search git log
# Ctrl+s -- search git status
# Ctrl+r -- search history
# Ctrl+p -- search processess
# Ctrl+n -- search npm lifecycle scripts
#

# capture unbound keys -- see https://fishshell.com/docs/current/cmds/bind.html
bind '' self-insert

# disable default fzf file / directory filter
set -gx FZF_CTRL_T_COMMAND ""

# Configure key bindings for patrickf1/fzf.fish
fzf_configure_bindings --directory=\ct --git_log=\cg --history=\cr --processes=\cp

# Bind Ctrl+S to stage files in git
bind \cs __fzf_git_stage_files

# Bind Ctrl+B to checkout a git branch
bind \cb __fzf_git_switch_branch

# Bind Ctrl+O to open files in vscode
bind \co __fzf_vscode_open_files

# Npm life cycle scripts bound to Ctrl+N.
bind \cn __fzf_npm_life_cycle_scripts
