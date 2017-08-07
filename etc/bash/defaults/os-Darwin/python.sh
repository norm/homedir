# github:norm/homedir:etc/bash/defaults/os-Darwin/python.sh
#
# Use homebrew python2.

# 'brew install python2' only gives a python2 binary in /usr/local/bin;
# so add the raw path
path_prepend '/usr/local/opt/python/libexec/bin'
