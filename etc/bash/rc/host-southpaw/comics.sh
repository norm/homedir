# github:norm/homedir:etc/bash/rc/host-southpaw/comics.sh
#
# Use filename completion on comic names.

need comics && {
    function _pushd {
        pushd "$1" >/dev/null
    }
    function _popd {
        popd >/dev/null
    }

    function _comics_names {
        local IFS=$'\n'
        _pushd /files/comics
        COMPREPLY=( $(compgen -d "${COMP_WORDS[COMP_CWORD]}") )
        _popd
    }

    function _comics {
        case "$COMP_CWORD" in
            1)  COMPREPLY=( new read )
                ;;
            *)  case "${COMP_WORDS[1]}" in
                    read)   _comics_names ;;
                    *)      ;;
                esac
                ;;
        esac
    }

    complete -o filenames -F _comics comics
}
