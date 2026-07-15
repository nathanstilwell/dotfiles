# time-log
#
# Description: A thing I'm going to use to log time spent on life
#
# usage: time-log --type hack (default) 25m

function time-log --argument-names time --description "A function to display a visual timer and log an entry upon completion"
  argparse 't/type=' 'f/file=' -- $argv

  set -l type "[HACK]"
  if set -q _flag_type
    set type $_flag_type
  end

  set -l file ~/.config/time-log.md;
  if set -q _flag_file
    set file $_flag_file
  end

  #
  # Test the that time-log.md file exists or create it.
  #

  # normalize the path (resolve symlinks, . and ..)
  set -l filepath (realpath $file)

  # expand any variables or leading tilde (~) in the path
  set filepath (eval echo $filepath)

  if not test -e $filepath
    set -l filedir (dirname $filepath)
    if not test -d $filedir
      mkdir -p $filedir
    end
    touch $filepath
    echo "# Time Log" >> $filepath
    echo >> $filepath
    echo "| Type   | Date     | Start  | End    | Duration |" >> $filepath
    echo "|--------|:--------:|:------:|:------:|---------:|" >> $filepath
  end

  # Go time!

  echo -n "| $type |"(date +"%Y-%m-%d")" | "(date +"%H:%M:%S")" | " >> $filepath;
  timer $time -f --format 24h -n $type;
  echo (date +"%H:%M:%S")" | $time |" >> $filepath
end

function show-time-log --description "show logged time entries"
  argparse 'f/file=' -- $argv

  set -l file ~/.config/time-log.md;
  if set -q _flag_file
    set file $_flag_file
  end

  set -l filepath (realpath $file)
  set filepath (eval echo $filepath)

  if not test -e $filepath
    echo "No time log found at $filepath"
    return
  end

  set viewer (type -q glow && echo "glow" || echo "cat")
  $viewer $filepath
end
