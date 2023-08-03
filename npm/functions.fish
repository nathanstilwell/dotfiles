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
