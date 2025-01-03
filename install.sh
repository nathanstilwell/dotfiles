#!/bin/bash

TARGET=$HOME;
CONFIG=$HOME/.config;
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


echo
echo -e "${bold:?}## Symlinking dotfiles to ~";
echo -e "--------------------------------------------${bold_off:?}"

for link in "$DOTS"/**/*.dotfile; do
  filename=$(basename "$link");

  [[ -e $link ]] && {
    dotfilename=".${filename%'.dotfile'}";

    [[ -e $TARGET/$dotfilename ]] && {
      echo -e "${yellow:?}Link already exists, skipping${stop:?} $dotfilename";
      continue;
    }
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
    symlinkname="${filename%'.symlink'}";

    [[ -e $TARGET/$symlinkname ]] && {
      echo -e "${yellow:?}Link already exists, skipping${stop:?} $symlinkname";
      continue;
    }
    echo -e "Symlinking ${green:?}$filename${stop:?} -> ${green:?}$TARGET/$symlinkname${stop:?}";
    ln -s "$link" "$TARGET/$symlinkname";
  };
done

echo
echo -e "${bold:?}## Linking symlinks to ~/.config";
echo -e "--------------------------------------------${bold_off:?}"

for link in "$DOTS"/**/*.config; do
  filename=$(basename "$link");

  [[ -e $link ]] && {
    configname="${filename%'.config'}";

    [[ -e $CONFIG/$configname ]] && {
      echo -e "${yellow:?}Link already exists, skipping${stop:?} $configname";
      continue;
    }
    echo -e "Symlinking ${green:?}$filename${stop:?} -> ${green:?}$CONFIG/$configname${stop:?}";
    ln -s "$link" "$CONFIG/$configname";
  };
done

echo
echo -e "${bold:?}## Homebrew";
echo -e "--------------------------------------------${bold_off:?}"
command -v brew > /dev/null || {
  echo -e "${bold:?}Installing homebrew${stop:?}";
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)" # add `brew` to the PATH
}

command -v brew > /dev/null && {
  echo "Homebrew is installed";
  brewpath="$(brew --prefix)/bin/brew";
  eval "$($brewpath shellenv)" # just in case `brew` isn't on the PATH
}

[[ -e "$HOME/Brewfile" ]] && {
  echo -e "${bold:?}Running ${green:?}brew bundle${stop:?}";
  cd "$HOME" || return;
  brew bundle;
  cd - || return;
}

# if not fish then change shell,
[ "$SHELL" != "$(brew --prefix)/bin/fish" ] && command -v fish > /dev/null && {
  echo
  echo -e "${bold:?}## Changing Shell";
  echo -e "--------------------------------------------${bold_off:?}"
  echo -e "Current user shell is ${green:?}$SHELL${stop:?}, changing user shell to ${green:?}fish${stop:?}.";

  echo "$(brew --prefix)/bin/fish" | sudo tee -a /etc/shells
  chsh -s "$(brew --prefix)/bin/fish";
}

# TODO: move this to `configuration.sh` script
# # Install fisher for fish plugins
# [ "$SHELL" == "$(brew --prefix)/bin/fish" ] && command -v fisher > /dev/null || {
#   echo
#   echo -e "${bold:?}## Installing Fisher";
#   echo -e "--------------------------------------------${bold_off:?}"
#   fish <<'END_FISH'
#       curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

#       echo -e "## Installing PatrickF1/fzf.fish";
#       echo -e "--------------------------------------------";
#       fisher install PatrickF1/fzf.fish
#   END_FISH

#   ln -s "$DOTS/fish/__fish_config__" "$CONFIG/fish/config.fish";
# }

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
defaults write com.apple.dock orientation left

echo -e "Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

echo -e "Make Dock icons small"
defaults write com.apple.dock tilesize -int 24

echo
echo -e "${bold:?}======================================"
echo -e "Install Complete - 🎉🎉🎉"
echo
echo -e "Restart your computer please."
echo -e "======================================${bold_off:?}"

# Cleanup
unset TARGET
unset DOTS
unset CONFIG
