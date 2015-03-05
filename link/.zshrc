# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="nathanstilwell"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Set Homebrew cask to install to /Applications
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(gerrit dock)

source "$ZSH/oh-my-zsh.sh"

#
# Load Aliases from Home Directory
#
if [ -f ~/.zsh_aliases ]; then
  . ~/.zsh_aliases
fi