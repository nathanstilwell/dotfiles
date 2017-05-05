#!/bin/bash

# Make sure dot files are copied to the right place?
DOTS=~/.dotfiles;

# Check and switch shell to zsh
# check shell with:
# env | grep SHELL

# if not zsh then,
#chsh /bin/zsh

# in case you forgot to clone --recursive
# git submodule init;
# git submodule update;

#
# Install stuff
#

# let's crank up some homebrew
# command -v brew > /dev/null || {
#   ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
# }

# install brew cask
# brew install caskroom/cask/brew-cask

# install brew bundle
# brew tap Homebrew/bundle

# then fire up the brew file
# cd $DOTS/install
# brew bundle

# link dotfiles
for file in $DOTS/link/.??*; do
  filename=$(basename "$file");
  [[ -e "$file" && -h ~/$filename ]] && rm ~/"$filename";
  [[ -e "$file" ]] && ln -s "$file" ~/;
done
unset file

# install oh-my-zsh fork
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/nathanstilwell/oh-my-zsh/master/tools/install.sh)"

unset DOTS


#
# Mac Sane Defaults

# turn off unicode glyphs
# defaults write -g ApplePressAndHoldEnabled -bool false

# Crank up the key repeat
# defaults write NSGlobalDomain KeyRepeat -int 1

# ask for password after screen saver
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0
