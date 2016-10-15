# github:norm/homedir:etc/bash/rc/filesystem.sh
#
# Working with files.

export BLOCKSIZE='1k'
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

alias du='du -h'
alias duh='du -shc *'
alias dus='du -sc * | sort -n'

alias ls='ls -F'
alias ll='ls -la'

alias mkdir='mkdir -p'
