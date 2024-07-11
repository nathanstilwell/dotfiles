# function to fuzzy find files and open in VS Code
#
#  "Inspired" by _fzf_search_directory.fish[^1]
#
# [^1]https://github.com/PatrickF1/fzf.fish/blob/main/functions/_fzf_search_directory.fish

function __fzf_vscode_open_files --description "Open files in VSCode"
  # Directly use fd binary to avoid output buffering delay caused by a fd alias, if any.
  set -f fd_cmd fd --color=always $fzf_fd_opts

  set -f fzf_arguments --multi --ansi $fzf_directory_opts
  set -f token (commandline --current-token)
  # expand any variables or leading tilde (~) in the token
  set -f expanded_token (eval echo -- $token)
  # unescape token because it's already quoted so backslashes will mess up the path
  set -f unescaped_exp_token (string unescape -- $expanded_token)

  # If the current token is a directory and has a trailing slash,
  # then use it as fd's base directory.
  if string match --quiet -- "*/" $unescaped_exp_token && test -d "$unescaped_exp_token"
      set --append fd_cmd --base-directory=$unescaped_exp_token
      # use the directory name as fzf's prompt to indicate the search is limited to that directory
      set --prepend fzf_arguments --prompt="Directory $unescaped_exp_token> " --preview="_fzf_preview_file $expanded_token{}"
      set -f file_paths_selected $unescaped_exp_token($fd_cmd 2>/dev/null | _fzf_wrapper $fzf_arguments)
  else
      set --prepend fzf_arguments --prompt="Directory> " --query="$unescaped_exp_token" --preview='_fzf_preview_file {}'
      set -f file_paths_selected ($fd_cmd 2>/dev/null | _fzf_wrapper $fzf_arguments)
  end


  if test $status -eq 0
      set -f escaped_file_paths (string escape -- $file_paths_selected | string join ' ');
      commandline --replace "code $escaped_file_paths"
  end

  commandline --function repaint
end

