function fish_prompt

    # define git functions if not already defined
    if not set -q -g __fish_git_functions_defined
        set -g __fish_git_functions_defined
        function _git_branch_name
            echo (git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
        end
        function _is_git_dirty
            echo (git status -s --ignore-submodules=dirty ^/dev/null)
        end
    end

    function collapse_pwd
      echo (pwd | sed -e "s,^$HOME,~,")
    end
    # define hostname if not already defined
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    # shortcuts for colors
    set -l cyan (set_color -o cyan)
    set -l green (set_color -o green)
    set -l magenta (set_color -o magenta)
    set -l red (set_color -o red)
    set -l blue (set_color -o blue)
    set -l normal (set_color normal)

    # cool emoji skull
    set -l clean "△"
    set -l dirty "▲"

    # user at host
    set -l user_host $cyan"$USER@$__fish_prompt_hostname"

    # set path
    set -l cwd (collapse_pwd)
    set git_status "$clean"

    # if git branch
    if [ (_git_branch_name) ]
        if [ (_is_git_dirty) ]
            set git_status "$dirty"
        end
        if [ (_git_branch_name) = "master" ]
          set git_info $green $git_status " "(_git_branch_name)$normal
        else
          set git_info $blue $git_status " "(_git_branch_name)$normal
        end
        # if dirty
    end

    echo -n -s "$git_info $git_branch $cwd ⫸  "
end