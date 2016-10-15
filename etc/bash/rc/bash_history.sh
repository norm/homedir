# github:norm/homedir:etc/bash/rc/bash_history.sh
#
# Exercise some control over how bash keeps history.

HISTCONTROL=erasedups
HISTFILESIZE=10000
HISTIGNORE='fhgr *:h:hgr *:history*:'
HISTSIZE=1000

shopt -s histappend

alias h='history 50'
alias hgr='history | egrep -i'

function fhgr {
    egrep -i "$@" $HISTFILE
}
