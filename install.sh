#!/bin/bash

TARGET=$HOME;
DOTS=$HOME/.dotfiles;

# shellcheck source=/dev/null #[SC1090] I don't care
source "$DOTS/utils/colors.sh";

echo
echo -e "~~ Replace me with some cool ASCII art ~~";
echo

# if not zsh then change shell,
[ "$SHELL" != "/bin/zsh" ] && {
  echo "Current user shell is $SHELL, changing user shell to zsh.";
  chsh -s /bin/zsh;
}

echo
echo -e "${bold:?}## Symlinking dotfiles to ~";
echo -e "--------------------------------------------${bold_off:?}"

for link in "$DOTS"/**/*.dotfile; do
  filename=$(basename "$link");

  [[ -e $link ]] && {
    dotfilename=".$(echo "$filename" | cut -d. -f1)";
    echo -e "Symlinking ${green:?}$filename${stop:?} -> ${green:?}$TARGET/$dotfilename${stop:?}";
    ln -s "$link" "$TARGET/$dotfilename";
  };
done

echo
echo -e "${bold:?}## Linking symlinks to ~";
echo -e "--------------------------------------------${bold_off:?}"

for link in "$DOTS"/**/*.symlink; do
  filename=$(basename "$link");

  [[ -e $link ]] && {
    symlinkname="$(echo "$filename" | cut -d. -f1)";
    echo -e "Symlinking ${green:?}$filename${stop:?} -> ${green:?}$TARGET/$symlinkname${stop:?}";
    ln -s "$link" "$TARGET/$symlinkname";
  };
done

echo
echo -e "${bold:?}## Homebrew";
echo -e "--------------------------------------------${bold_off:?}"
command -v brew > /dev/null || {
  echo "${bold:?}Installing homebrew${stop:?}";
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
} && {
  echo "Homebrew is already installed";
}

# install brew cask
# brew install caskroom/cask/brew-cask

# install brew bundle
# brew tap Homebrew/bundle

# then fire up the brew file
# cd $DOTS/install
# brew bundle

# Mac Sane Defaults
echo
echo -e "${bold:?}## Setting Mac Defaults";
echo -e "--------------------------------------------${bold_off:?}"

echo -e "Turning off unicode glyphs";
defaults write -g ApplePressAndHoldEnabled -bool false

echo -e "Crank up the key repeat";
defaults write NSGlobalDomain KeyRepeat -int 1

echo -e "Ask for password after screen saver"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo -e "Show hidden files in Finder"
defaults write com.apple.finder AppleShowAllFiles YES

# Cleanup
unset TARGET
unset DOTS
