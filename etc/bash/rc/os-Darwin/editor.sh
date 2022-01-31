# github:norm/homedir:etc/bash/rc/os-Darwin/editor.sh
#
# Improved visual editor settings.

export EXINIT='set sw=4 ai list'

# Prefer Sublime Text over vi
need subl && {
    export VISUAL=subl
    available sublime && export VISUAL=sublime
}
