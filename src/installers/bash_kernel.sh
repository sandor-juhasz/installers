#!/bin/bash
###############################################################################
#
# Installs the Bash kernel in a virtualenv.
#
# Environment:
#    USERNAME   The user for which pyenv is configured.
###############################################################################

source lib/common.sh

USERNAME=${1:$(id -un)}         # install python for current user by default.

echo "Installing bash_kernel for $USERNAME..."

as_user "pyenv virtualenv bash_kernel && pyenv activate bash_kernel && pip install bash_kernel && python -m bash_kernel.install"