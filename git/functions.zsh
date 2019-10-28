function current_branch() {
	git symbolic-ref --short -q HEAD
}

function prune {
  git fetch --all --prune;
  git rebase;
  for branch in `git branch -vv | grep ': gone]' | awk '{print $1}'`;
    do hub branch -D $branch;
  done
}

