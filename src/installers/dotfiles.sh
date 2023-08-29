#!/bin/bash
###############################################################################
# Installs dotfiles
###############################################################################

set -e

source lib/common.sh

export USERNAME=${1:-developer}

as_user 'bash -c "$(curl -fsSL https://raw.githubusercontent.com/sandor-juhasz/dotfiles/master/install-local.sh)"'

