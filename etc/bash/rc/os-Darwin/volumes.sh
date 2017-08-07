# github:norm/homedir:etc/bash/rc/os-Darwin/volumes
#
# Working with volumes (mounted disks) in OS X.

function eject {
    hdiutil eject "/Volumes/$*"
}

function _eject {
    local current="${COMP_WORDS[COMP_CWORD]}"
    local    opts=""

    case "$COMP_CWORD" in
        1)  pushd /Volumes                      >/dev/null
            local IFS=$'\n'
            opts=$( /bin/ls )
            COMPREPLY=( $(compgen -W "${opts}" -- ${current} ) )
            popd                                >/dev/null
    esac
}

complete -F _eject eject
