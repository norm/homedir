# github:norm/homedir:etc/bash/rc/asdf.sh
#
# Initialise asdf.

export ASDF_DIR=$HOME/var/asdf
export ASDF_DATA_DIR=$HOME/var/asdf
source_or_warn $ASDF_DIR/asdf.sh
source_or_warn $ASDF_DIR/completions/asdf.bash
