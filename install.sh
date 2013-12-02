DOTS=~/.dotfiles;

# install stuff
for installer in $DOTS/install/*; do
  [ -e "$installer" ] && $installer;
done
unset installer

# link dotfiles
for file in $DOTS/link/.??*; do
  filename=$(basename $file);
  [[ -e "$file" && -h ~/$filename ]] && rm ~/$filename;
  [[ -e "$file" ]] && ln -s "$file" ~/;
done
unset file

unset DOTS
