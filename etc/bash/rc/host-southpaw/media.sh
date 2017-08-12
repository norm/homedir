# github:norm/homedir:etc/bash/rc/host-southpaw/media.sh
#
# Settings for dealing with media, especially anything to do with
# https://github.com/norm/media-tools.

export MEDIA_CONFIG="${HOME}/etc/media.conf"


# List the episodes in the most recent season of a TV show.
function tv {
    local show="${1//\//}";
    local season=$(
        /bin/ls "/files/tv/${show}/" \
            | awk '/Season / { print $2 }' \
            | sort -rn \
            | head -1
    )

    print "${bold}${red}${show} Season ${season}:${reset}"
    ls "/files/tv/${show}/Season ${season}"
}

complete -o filenames -F _tv_series tv
