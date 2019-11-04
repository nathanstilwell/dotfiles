function npm-burn {
  # rm -rf node_modules;
  # rm package-lock.json;
  [[ -d node_modules ]] && rm -rf node_modules;
  [[ -e package-lock.json ]] && rm package-lock.json;
  [[ -e yarn.lock ]] && rm yarn.lock;
}
