##       ██                  ██
##      ░██                 ░██
##      ░██ ██   ██ ███████ ░██  ██
##      ░██░██  ░██░░██░░░██░██ ██
##      ░██░██  ░██ ░██  ░██░████
##  ██  ░██░██  ░██ ░██  ░██░██░██
## ░░█████ ░░██████ ███  ░██░██░░██
##  ░░░░░   ░░░░░░ ░░░   ░░ ░░  ░░
##
##  ███████
## ░██░░░░██
## ░██    ░██ ██████  ██████   ███     ██  █████  ██████
## ░██    ░██░░██░░█ ░░░░░░██ ░░██  █ ░██ ██░░░██░░██░░█
## ░██    ░██ ░██ ░   ███████  ░██ ███░██░███████ ░██ ░
## ░██    ██  ░██    ██░░░░██  ░████░████░██░░░░  ░██
## ░███████  ░███   ░░████████ ███░ ░░░██░░██████░███
## ░░░░░░░   ░░░     ░░░░░░░░ ░░░    ░░░  ░░░░░░ ░░░

function take --description "Create a directory and change to it"
  command mkdir -p $argv
  if test $status = 0
    cd $argv[1];
  end
end

function untar --description "Unpack a tarball"
  command tar -zxvf $argv
end

function getip
  ifconfig en0 | grep -w 'inet' | awk '{print $2}';
end

function stats
  history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
end


function shrug --description "copy a shrug text emoji"
   echo "¯\_(ツ)_/¯" | pbcopy;
end


function table --description "copy table flip text emoji"
  echo " (╯°□°）╯︵ ┻━┻" | pbcopy;
end

