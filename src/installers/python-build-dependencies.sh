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

apt_install build-essential libssl-dev zlib1g-dev \
            libbz2-dev libreadline-dev libsqlite3-dev curl \
            libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
            git curl ca-certificates --no-install-recommends