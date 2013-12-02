# Aliases
alias g='git'
compdef g=git

alias gst='git status'
compdef _git gst=git-status

alias gl='git pull'
compdef _git gl=git-pull

alias gup='git fetch && git rebase'
compdef _git gup=git-fetch

alias gp='git push'
compdef _git gp=git-push

alias gc='git commit -v'
compdef _git gc=git-commit

alias gci='git commit -v -m'
compdef _git gci=git-commit

alias gdf='git diff HEAD'
compdef _git gdf=git-diff

alias gca='git commit -v -a -m'
compdef _git gca=git-commit

alias gco='git checkout'
compdef _git gco=git-checkout

alias gb='git branch'
compdef _git gb=git-branch

alias gba='git branch -a'
compdef _git gba=git-branch

alias gcount='git shortlog -sn'
compdef gcount=git

alias glg='git log --stat --max-count=5'
compdef _git glg=git-log

alias grh='git reset HEAD'
compdef _git grh=git

alias gdt='git difftool HEAD'
compdef _git gdt=git-difftool

alias gsh='git ksshow'
compdef _git gdt=git

alias gsu='git submodule update'
compdef _git gsu=git

#
# Will return the current branch name
# Usage example: git pull origin $(current_branch)
#
function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

# these aliases take advantage of the previous function
alias ggpull='git pull origin $(current_branch)'
compdef ggpull=git

alias ggpush='git push origin $(current_branch)'
compdef ggpush=git

alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'
compdef ggpnp=git
