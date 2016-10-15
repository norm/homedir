# github:norm/homedir:etc/bash/rc/file_find.sh
#
# Searching for things in files.

alias f='find .'
alias ff='find . -type f'
alias fgr='find . | egrep -i'
alias ffgr='find . -type f | egrep -i'
alias fgx='find . -type f -print0 | xargs -0 egrep -i'

available ack \
    && alias fgx='ack -ai'

available ag \
    && alias fgx='ag -ai'
