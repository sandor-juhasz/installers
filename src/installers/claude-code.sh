#!/bin/bash
###############################################################################
#
# Installs Claude Code
#
###############################################################################

set -e

USERNAME=${1:$(id -un)}

source lib/common.sh

cat <<EOF
Installing Claude Code...
=========================
Parameters:
   USERNAME: $USERNAME

EOF

su --login "$USERNAME" <<'EOF'
    curl -fsSL https://claude.ai/install.sh | bash
EOF

echo "Done."
