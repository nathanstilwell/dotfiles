#!/usr/bin/env bash

function git_prompt () {
  if [ -d .git ]; then
    echo -e " on $magenta$(current_branch)$stop at $blue$(git_prompt_short_sha)$stop";
  fi;
}

function git_prompt_short_sha () {
  echo "$(command git rev-parse --short HEAD 2> /dev/null)";
}

function current_branch () {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ${ref#refs/heads/}
}
