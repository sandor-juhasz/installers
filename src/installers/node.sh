#!/bin/bash
###############################################################################
#
# Installs the latest LTS Node runtime.
#
###############################################################################

set -e

USERNAME=${1:-$(id -un)}

source lib/common.sh

cat <<EOF
Installing Node LTS...
======================
Parameters:
   USERNAME: $USERNAME

EOF

su --login "$USERNAME" <<'EOF'
    if [[ ! -d ~/.nvm ]]; then
        echo "ERROR: Cannot find NVM. Please install it before executing this installer."
        exit 1
    fi

    nvm install --lts
EOF

echo "Done."
