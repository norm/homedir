# github:norm/homedir:etc/bash/rc/diff.sh
#
# Working with diffs.

alias diff='diff -u'

available colordiff \
    && alias diff='colordiff -u'
