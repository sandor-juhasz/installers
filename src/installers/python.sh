#!/bin/bash
###############################################################################
#
# Installs a given Python environment under the specified user using pyenv.
#
# Environment:
#    USERNAME   The user for which pyenv is configured.
#    PYTHON_VERSION
###############################################################################

source lib/common.sh

set -e

USERNAME=${1:$(id -un)}         # install python for current user by default.
PYTHON_VERSION=${2:-3.11.4}

if [[ "${PYTHON_VERSION}" == "system" ]]; then
    echo "Installing pip for System python..."
    apt_install python3-pip
    echo "Configuring System python as default..."
    as_user "pyenv global system"
    as_user "mkdir -p ~/.local/bin"
else
    echo "Installing Python $PYTHON_VERSION for $USERNAME..."

    apt_install build-essential libssl-dev zlib1g-dev \
                libbz2-dev libreadline-dev libsqlite3-dev curl \
                libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
                git curl ca-certificates --no-install-recommends

    as_user "pyenv install $PYTHON_VERSION && pyenv global $PYTHON_VERSION && pip install --upgrade pip"
    as_user "mkdir -p ~/.local/bin"
fi