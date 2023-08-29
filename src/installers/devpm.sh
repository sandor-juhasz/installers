#!/bin/bash
###############################################################################
# Installs devpm 
###############################################################################

set -e

source lib/common.sh

export USERNAME=${1:-developer}

as_user 'bash -c "$(curl -fsSL https://raw.githubusercontent.com/sandor-juhasz/devpm/main/install)"'
