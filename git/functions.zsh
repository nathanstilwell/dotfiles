function current_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}

function prune {
  git fetch --prune;
  git rebase;
  for branch in `git branch -vv | grep ': gone]' | awk '{print $1}'`;
    do hub branch -D $branch;
  done
}

