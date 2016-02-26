#!/usr/bin/evn bash

function git_prompt_short_sha() {
  SHA=$(command git rev-parse --short HEAD 2> /dev/null) && echo ":: $SHA"
}
