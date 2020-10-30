# the goods

# source ~/.config/fish/aliases.fish;

set --local DOTS "$HOME/.dotfiles";

for config_file in $DOTS/**/*.fish
  # echo "sourcing $config_file";
  source $config_file;
end
