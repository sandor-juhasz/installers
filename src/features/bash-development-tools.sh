# shellcheck shell=bash
#
# Installs a base python environment in a user's home directory.
#
# The specified C Python versions are installed using pyenv in the user's home
# directory. This Python runtime is configures as the default for the user.
# The pipx application is set up using the default Python runtime.
#
# Environment:
#    USERNAME                The user name of the user for which the feature is installed.
#

export INSTALL_BASH_KERNEL=${INSTALL_BASH_KERNEL:-"true"}

function install() {
    # todo: install basic Python runtime if not installed.

    installers/shell-base.sh "${USERNAME}"
    installers/shellcheck.sh

    if [[ "${INSTALL_BASH_KERNEL}" = "true" ]]; then
        if [[ ! -d "/home/$USERNAME/.pyenv" ]]; then
            export DEFAULT_PYTHON_VERSION="system"
            features/python-base-environment.sh
        fi
        installers/bash_kernel.sh "${USERNAME}"
    fi
}

install
