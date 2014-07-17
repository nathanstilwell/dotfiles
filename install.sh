#!/bin/bash
DOTS=~/.dotfiles;

#
# Install stuff stuff
#

# install OSX Defaults a la http://mths.be/osx
sudo sh $DOTS/install/set_osx_defaults

# let's crank up some homebrew
test command -v brew > /dev/null || {
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"
}

# install brew cask
brew install caskroom/cask/brew-cask

# then fire up the brew file
brew bundle $DOTS/install/Brewfile


# link dotfiles
for file in $DOTS/link/.??*; do
  filename=$(basename $file);
  [[ -e "$file" && -h ~/$filename ]] && rm ~/$filename;
  [[ -e "$file" ]] && ln -s "$file" ~/;
done
unset file

unset DOTS
