
#   ██   ██                  ██████   ██               ██
#  ░██  ██           ██   ██░█░░░░██ ░░               ░██
#  ░██ ██    █████  ░░██ ██ ░█   ░██  ██ ███████      ░██  ██████
#  ░████    ██░░░██  ░░███  ░██████  ░██░░██░░░██  ██████ ██░░░░
#  ░██░██  ░███████   ░██   ░█░░░░ ██░██ ░██  ░██ ██░░░██░░█████
#  ░██░░██ ░██░░░░    ██    ░█    ░██░██ ░██  ░██░██  ░██ ░░░░░██
#  ░██ ░░██░░██████  ██     ░███████ ░██ ███  ░██░░██████ ██████
#  ░░   ░░  ░░░░░░  ░░      ░░░░░░░  ░░ ░░░   ░░  ░░░░░░ ░░░░░░

#
# All bound on Alt+Ctrl+<letter> -- kept off plain Ctrl+<letter> because that space is
# already claimed by Fish's own default emacs-mode bindings. See docs/KEYBINDINGS.md.
#
# fzf_configure_bindings has six commands, not four -- git_status and variables have their
# own plugin defaults (Alt+Ctrl+S and Ctrl+V respectively, per `fzf_configure_bindings --help`)
# that stay active for any command you don't explicitly pass a flag for. Both are configured
# explicitly below so nothing is left running on an unaccounted-for default.
#
# Alt+Ctrl+t -- search directory
# Alt+Ctrl+g -- search git log
# Alt+Ctrl+s -- search git status
# Alt+Ctrl+a -- stage files in git (git add)
# Alt+Ctrl+v -- search variables
# Alt+Ctrl+r -- search history
# Alt+Ctrl+p -- search processess
# Alt+Ctrl+n -- search npm lifecycle scripts
# Alt+Ctrl+b -- checkout git branch
#
# __fzf_vscode_open_files (vs-code/functions.fish) is intentionally unbound -- kept for
# possible future use, but not needed while developing in Nvim exclusively.

# capture unbound keys -- see https://fishshell.com/docs/current/cmds/bind.html
bind '' self-insert

# disable default fzf file / directory filter
set -gx FZF_CTRL_T_COMMAND ""

# Configure key bindings for patrickf1/fzf.fish
fzf_configure_bindings --directory=\e\ct --git_log=\e\cg --git_status=\e\cs --history=\e\cr --processes=\e\cp --variables=\e\cv

# Bind Alt+Ctrl+A to stage files in git (git add)
bind \e\ca __fzf_git_stage_files

# Bind Alt+Ctrl+B to checkout a git branch
bind \e\cb __fzf_git_switch_branch

# Npm life cycle scripts bound to Alt+Ctrl+N.
bind \e\cn __fzf_npm_life_cycle_scripts
