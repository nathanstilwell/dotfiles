function current_branch  --description "Get current git branch"
	echo (git symbolic-ref --short -q HEAD)
end


function prune --description "Delete git branches that have lost remotes"
  git fetch --all --prune;
  git rebase;
  for branch in (git branch -vv | grep ': gone]' | awk '{print $1}');
    do hub branch -D $branch;
  end
end

