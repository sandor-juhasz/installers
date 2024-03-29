#!/bin/bash
###############################################################################
#
# Installs AWS CDK
#
###############################################################################

set -e

USERNAME=${1:$(id -un)}

source lib/common.sh

cat <<EOF
Installing AWS CDK...
=====================
Parameters:
   USERNAME: $USERNAME

EOF

su --login "$USERNAME" <<'EOF'
    npm install -g aws-cdk
EOF

echo "Done."
