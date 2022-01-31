# github:norm/homedir:etc/bash/rc/file_find.sh
#
# Searching for things in files.

alias f='find .'
alias ff='find . -type f'
alias fgr='find . | egrep -i'
alias ffgr='find . -type f | egrep -i'
alias fgx='find . -type f -print0 | xargs -0 egrep -i'

# prefer ack over grep
available ack \
    && alias fgx='ack -ai'

# prefer the_silver_searcher over ack
available ag \
    && alias fgx='ag -ai'

# prefer ripgrep over the_silver_searcher
available rg && {
    alias fgx='rg --smart-case --no-ignore --hidden'
    alias rg='rg --smart-case'
}
