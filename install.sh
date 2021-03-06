#!/bin/bash

TARGET=$HOME;
DOTS=$HOME/.dotfiles;

# shellcheck source=/dev/null #[SC1090] I don't care
source "$DOTS/utils/colors.sh";

echo
echo
echo -e "${red:?}    ██                    ██              ██  ██ ██                 ";
echo -e "${orange:?}   ░██                   ░██             ░██ ░██░░            █████ ";
echo -e "${yellow:?}   ░██ ███████   ██████ ██████  ██████   ░██ ░██ ██ ███████  ██░░░██";
echo -e "${green:?}   ░██░░██░░░██ ██░░░░ ░░░██░  ░░░░░░██  ░██ ░██░██░░██░░░██░██  ░██";
echo -e "${cyan:?}   ░██ ░██  ░██░░█████   ░██    ███████  ░██ ░██░██ ░██  ░██░░██████";
echo -e "${blue:?}   ░██ ░██  ░██ ░░░░░██  ░██   ██░░░░██  ░██ ░██░██ ░██  ░██ ░░░░░██";
echo -e "${purple:?}   ░██ ███  ░██ ██████   ░░██ ░░████████ ███ ███░██ ███  ░██  █████ ";
echo -e "${magenta:?}   ░░ ░░░   ░░ ░░░░░░     ░░   ░░░░░░░░ ░░░ ░░░ ░░ ░░░   ░░  ░░░░░  ";
echo
echo -e "${red:?}       ███████              ██     ████ ██  ██                ";
echo -e "${orange:?}      ░██░░░░██            ░██    ░██░ ░░  ░██                ";
echo -e "${yellow:?}      ░██    ░██  ██████  ██████ ██████ ██ ░██  █████   ██████";
echo -e "${green:?}      ░██    ░██ ██░░░░██░░░██░ ░░░██░ ░██ ░██ ██░░░██ ██░░░░ ";
echo -e "${cyan:?}      ░██    ░██░██   ░██  ░██    ░██  ░██ ░██░███████░░█████ ";
echo -e "${blue:?}      ░██    ██ ░██   ░██  ░██    ░██  ░██ ░██░██░░░░  ░░░░░██";
echo -e "${purple:?}      ░███████  ░░██████   ░░██   ░██  ░██ ███░░██████ ██████ ";
echo -e "${magenta:?}      ░░░░░░░    ░░░░░░     ░░    ░░   ░░ ░░░  ░░░░░░ ░░░░░░  ";
echo -e "${stop:?}";

# if not zsh then change shell,
[ "$SHELL" != "/bin/zsh" ] && {
  echo
  echo -e "${bold:?}## Changing Shell";
  echo -e "--------------------------------------------${bold_off:?}"
  echo -e "Current user shell is ${green:?}$SHELL${stop:?}, changing user shell to ${green:?}zsh${stop:?}.";
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
  echo -e "${bold:?}Installing homebrew${stop:?}";
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
} && {
  echo "Homebrew is already installed";
}

[[ -e "$HOME/Brewfile" ]] && {
  echo -e "${bold:?}Running ${green:?}brew bundle${stop:?}";
  cd "$HOME" || return;
  brew bundle;
  cd - || return;
}

#
# Install Fonts
#
echo
echo -e "${bold:?}## Installing Fonts";
echo -e "--------------------------------------------${bold_off:?}"

# fetch font details
font_url_path="https://osdn.net/dl/mplus-fonts";
font_url_file="mplus-TESTFLIGHT-063.tar.xz";
font_url="$font_url_path/$font_url_file";

# setup temp directory

TEMP_DIR="./tmp";
LOCAL_FONT_DIR="$HOME/Library/Fonts";
# SYSTEM_FONT_DIR="/Library/Fonts";

mkdir $TEMP_DIR;

# download and unpack fonts
command -v wget > /dev/null && {
  echo -e "${green:?}fetching fonts from $font_url ${stop:?}";
  wget -P $TEMP_DIR $font_url
  echo

  echo -e "${green:?}unzipping fonts to temp dir ${stop:?}";
  tar -zxvf "$TEMP_DIR/$font_url_file" --directory $TEMP_DIR

  echo -e "${green:?}copying fonts from $TEMP_DIR to $LOCAL_FONT_DIR${stop:?}";
  # shellcheck disable=SC2086
  cp -v $TEMP_DIR/**/*.ttf $LOCAL_FONT_DIR;
}

command -v wget > /dev/null || {
  echo -e "${red:?} Couldn't download with wget. Please download fonts from $font_url ${stop:?}";
}

# cleanup
rm -r $TEMP_DIR
unset font_url_path
unset font_url_file
unset font_url

# Mac Sane Defaults
echo
echo -e "${bold:?}## Setting Mac Defaults";
echo -e "--------------------------------------------${bold_off:?}"

echo -e "Turning off unicode glyphs";
defaults write -g ApplePressAndHoldEnabled -bool false

echo -e "Crank up the key repeat";
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo -e "Ask for password after screen saver"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo -e "Show hidden files in Finder"
defaults write com.apple.finder AppleShowAllFiles YES

echo -e "Show only open applications in the Dock"
defaults write com.apple.dock static-only -bool true

echo -e "Put Dock on the left"
defaults write com.apple.dock -string "left"

echo -e "Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

echo -e "Make Dock icons small"
defaults write com.apple.dock tilesize -int 24

# Cleanup
unset TARGET
unset DOTS
