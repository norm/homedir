# github:norm/homedir:etc/bash/rc/less.sh
#
# Prefer less to more.

export PAGER='less'

alias more='less'

need lesspipe.sh && {
    export LESSOPEN='| lesspipe.sh %s';
    export LESS='-R';
}

need pygmentize && \
    export LESSCOLORIZER='pygmentize'
