# helper functions for 1password cli
function opon () {
  if [[ -z $OP_SESSION_my ]]; then
    eval $(op signin my)
  fi
}

function opoff () {
  op signout
  unset OP_SESSION_my
}

function getpwd() {
  opon
  op get item "$1" --fields password
}

function get2fa() {
  opon
  op get totp "$1"
}
