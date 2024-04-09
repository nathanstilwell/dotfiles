function current_branch  --description "Get current git branch"
	echo (git symbolic-ref --short -q HEAD)
end


function prune --description "Delete git branches that have lost remotes"
  git fetch --all --prune;
  git rebase;
  for branch in (git branch -vv | grep ': gone]' | awk '{print $1}')
    git branch -D $branch;
  end
end

#
# Shamelessly stolen from _fzf_search_git_status.fish[^1]
# for the purpose of staging files the contain parentheses in
# their paths. This function depends on PatrickF1/fzf.fish being
# installed.
#
# [1]: https://github.com/PatrickF1/fzf.fish/blob/dfdf69369bd3a3c83654261f90363da2aa1db8c9/functions/_fzf_search_git_status.fish
#
function __fzf_git_stage_files --description "Fuzzy search for files to stage"
  if git rev-parse --git-dir >> /dev/null 2>&1
    set -f preview_cmd '_fzf_preview_changed_file {}'
    if set --query fzf_diff_highlighter
        set preview_cmd "$preview_cmd | $fzf_diff_highlighter"
    end

    set -f selected_paths (
        # Pass configuration color.status=always to force status to use colors even though output is sent to a pipe
        git -c color.status=always status --short |
        _fzf_wrapper --ansi \
            --multi \
            --prompt="Git Status> " \
            --query=(commandline --current-token) \
            --preview=$preview_cmd \
            --nth="2.." \
            $fzf_git_status_opts
    )

    if test $status -eq 0
        # Escape parentheses in paths
        #set -f escaped_paths (echo $selected_paths | sed 's/(/\\\(/g' | sed 's/)/\\\)/g');
        set -f cleaned_paths

        for path in $selected_paths
            set -f escaped (echo $path | sed 's/(/\\\(/g' | sed 's/)/\\\)/g');

            if test (string sub --length 1 $escaped) = R
                # path has been renamed and looks like "R LICENSE -> LICENSE.md"
                # extract the path to use from after the arrow
                set --append cleaned_paths (string split -- "-> " $escaped)[-1]
            else
                set --append cleaned_paths (string sub --start=4 $escaped)
            end
        end
        commandline --current-token --replace -- "git add "(string join " " $cleaned_paths);
    end
    commandline -f repaint
  end
end

function __fzf_git_checkout_branch --description "Fuzzy select a branch to checkout"
  if git rev-parse --git-dir >> /dev/null 2>&1
    set -f branch_output (
      git branch --list --format='%(refname:short) %(if:notequals=)%(upstream:short)%(then) 󰤉 %(end)' |
      _fzf_wrapper --ansi \
        --prompt="Checkout Branch> " \
        --pointer=" " \
        --query=(commandline --current-token) \
        --preview="git log --oneline --graph --decorate --color=always {1}" \
        --reverse
    )

    if test $status -eq 0
        set -f branch (echo $branch_output | awk '{print $1}')
        git checkout $branch;
    end

    commandline -f repaint
  end
end