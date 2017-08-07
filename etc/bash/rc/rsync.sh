# github:norm/homedir:etc/bash/rc/rsync.sh
#
# Commonly used rsync options.

rs_ignore="--exclude '.Trash'"
rs_ignore="${rs_ignore} --exclude '.Trashes'"
rs_ignore="${rs_ignore} --exclude '.Spotlight-V100'"
rs_ignore="${rs_ignore} --exclude '.DS_Store'"

alias rs="rsync -avHP ${rs_ignore}"
alias rsd="rs --delete"

available _rsync && {
    complete -o filenames -o nospace -F _rsync rsy
    complete -o filenames -o nospace -F _rsync rsyd
}
