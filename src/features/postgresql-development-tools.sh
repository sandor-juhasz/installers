# shellcheck shell=bash
#
# Installs the Oracle development tools.
#
# Environment:
#    USERNAME                The user name of the user for which the feature is installed.
#

set -e

export INSTALL_PSQL=${INSTALL_PSQL:-"true"}

function install() {
    installers/shell-base.sh "${USERNAME}"

    if [[ "${INSTALL_PSQL}" == "true" ]]; then
        installers/psql.sh "${USERNAME}"
    fi
}

install