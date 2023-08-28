#!/bin/bash
###############################################################################
#
# Installs the `pyenv` application.
#
# Environment:
#    USERNAME   The user for which pyenv is configured.
###############################################################################

set -e

source lib/common.sh

echo "Installing pyenv..."
echo "==================="

if [[ "$USERNAME" == "root" ]]; then
    user_home_dir="/root"
else 
    user_home_dir="/home/$USERNAME"
fi
echo "Using home directory: $user_home_dir"

if [ ! -d "$user_home_dir/.pyenv" ]; then 
    echo "~/.pyenv directory was not found. Installing pyenv for $USERNAME..."

    export DEBIAN_FRONTEND=noninteractive

    apt_install git curl ca-certificates

    as_user "curl https://pyenv.run | bash"

    install -T installers/files/pyenv.sh "$user_home_dir/.config/bashrc.d/pyenv.sh" --owner=$USERNAME --group=$USERNAME
    install -T installers/files/pyenv.sh "$user_home_dir/.config/profile.d/pyenv.sh" --owner=$USERNAME --group=$USERNAME
    install -T installers/files/pyenv.sh "$user_home_dir/.config/zshrc.d/pyenv.sh" --owner=$USERNAME --group=$USERNAME
else
    echo "Pyenv is already installed, skipping this step."
fi