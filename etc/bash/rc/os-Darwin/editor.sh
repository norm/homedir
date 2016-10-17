# github:norm/homedir:etc/bash/rc/os-Darwin/editor.sh
#
# Improved visual editor settings.

# Prefer textmate over vi, but...
available mate \
    && available textmate \
    && export VISUAL=textmate

# ...prefer Sublime Text over TextMate. Set to need rather than available to
# trigger a warning if it is not installed, as it is the preferred editor.
need subl \
    && available sublime \
    && export VISUAL=sublime
