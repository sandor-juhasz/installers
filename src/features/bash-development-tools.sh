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

source lib/common.sh

export INSTALL_BASH_KERNEL=${INSTALL_BASH_KERNEL:-"true"}
export INSTALL_VSCODE_EXTENSIONS=${INSTALL_VSCODE_EXTENSIONS:-"false"}

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

    # #
    # # NOTE: On WSL, the platform VSCode cannot be executed if it is invoked through su / sudo.
    # #       Updagint the PATH is not 
    # #
    # if [[ "${INSTALL_VSCODE_EXTENSIONS}" = "true" ]]; then
    #     echo "Installing VSCode extensions..."
    #     as_user "code --install-extension 'timonwong.shellcheck'"
    #     as_user "code --install-extension 'rogalmic.bash-debug'"
    #     as_user "code --install-extension 'ms-toolsai.jupyter'"
    # fi
}

install
