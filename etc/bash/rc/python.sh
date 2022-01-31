# github:norm/homedir:etc/bash/rc/python.sh
#
# Working with python.

export WORKON_HOME="${HOME}/var/virtualenvs"

need asdf && {
    source_or_warn "$(asdf which virtualenvwrapper.sh)"

    alias serve='python -m http.server'
}
