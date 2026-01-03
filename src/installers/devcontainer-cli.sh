#!/bin/bash
###############################################################################
#
# Installs Devcontainer CLI
#
###############################################################################

set -e

USERNAME=${1:$(id -un)}

source lib/common.sh

cat <<EOF
Installing Devcontainer CLI...
=====================
Parameters:
   USERNAME: $USERNAME

EOF

su --login "$USERNAME" <<'EOF'
    npm install -g @devcontainers/cli
EOF

echo "Done."
