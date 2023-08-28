#!/bin/bash
###############################################################################
#
# Installs a given Python environment under the specified user using pyenv.
#
# Environment:
#    USERNAME   The user for which pyenv is configured.
###############################################################################

source lib/common.sh

USERNAME=${1:$(id -un)}         # install python for current user by default.

echo "Initializing shell base files for user $USERNAME..."

apt_install bash-completion

as_user "cd $PWD; ./installers/scripts/init-shell-base.sh"
