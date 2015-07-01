export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# prompt
# For more colors : http://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/
export PS1="\[\e[0;31m\\H\e[m in \e[0;36m[\\w]\e[m>\]"

# source files
for file in ~/.dotfiles/source/*; do
  [ -e "$file" ] && source "$file"
done
unset file

#
# Load System Specific Aliases
#
if [ -f ~/.profile ]; then
  . ~/.profile
fi

export PATH="/usr/local/heroku/bin:/Users/nstilwell/.rbenv/shims:/Users/nstilwell/.rbenv/bin:/web/web-port-registry/bin:/web/util-eng/bin:/web/tools/bin:/web/play-2.0:/usr/local/bin/scala/bin/:/opt/local/bin:/opt/local/sbin:/opt/local/lib/postgresql90/bin:/web/tools/bin:/usr/X11/bin:/usr/local/git/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/opt/:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/nstilwell/.bashhub/bin:/Users/nstilwell/bin"
