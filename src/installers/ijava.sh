#!/bin/bash
###############################################################################
#
# Installs the IJava kernel in a virtualenv.
#
# Environment:
#    USERNAME   The user for which pyenv is configured.
###############################################################################

source lib/common.sh

USERNAME=${1:$(id -un)}         # install python for current user by default.

echo "Installing IJava kernel for $USERNAME..."

su --login "$USERNAME" <<'EOF'
    set -e

    mkdir -p /tmp/ijava
    curl -fsSL "https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip" \
     -o "/tmp/ijava/ijava-1.3.0.zip"
    cd /tmp/ijava
    unzip ijava-1.3.0.zip

    pyenv virtualenv ijava
    pyenv activate ijava
    pip install jupyter_client

    python3 install.py --user
EOF
