function npm-burn -d "delete node_modules and lock files from javascript projects"
  # rm -rf node_modules;
  # rm package-lock.json;
  #[[ -d node_modules ]] && rm -rf node_modules;
  if test -d node_modules
    rm -rf node_modules;
  end
  #[[ -e package-lock.json ]] && rm package-lock.json;
  if test -e package-lock.json
    rm package-lock.json;
  end
  #[[ -e yarn.lock ]] && rm yarn.lock;
  if test -e yarn.lock
    rm yarn.lock;
  end
end

function __fzf_npm_life_cycle_scripts -d "use fzf to find and run life cycle scripts"
  if test -e package.json && command -v pnpm >> /dev/null
    set -f scripts (cat package.json \
    | jq -r '.scripts | to_entries | map("  \(.key) -- \(.value)") | .[] ' \
    | fzf --prompt 'run script: ' --layout=reverse --height=~40% --info=inline --border);

    if test -n "$scripts"
      set -f script_name (string trim $scripts | awk -F ' -- ' '{print $1}')
      pnpm run $script_name $argv;
    end
    commandline -f repaint;
  end
end

# Maybe these should go in config.fish or `fish_user_key_bindings`
bind '' self-insert
bind \cN __fzf_npm_life_cycle_scripts