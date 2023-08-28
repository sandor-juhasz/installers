#!/bin/bash
###############################################################################
#
# Installs PIPX for the current user's default Python runtime.
#
# Environment:
#    USERNAME   The user for which pyenv is configured.
###############################################################################

source lib/common.sh

echo "Installing Python $PYTHON_VERSION for $USERNAME..."

as_user "mkdir -p ~/.local/bin"
as_user "pip install pipx "
