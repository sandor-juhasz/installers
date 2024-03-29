# shellcheck shell=bash
#
# Installs the Oracle development tools.
#
# Environment:
#    USERNAME                The user name of the user for which the feature is installed.
#

set -e

export INSTALL_INSTANTCLIENT=${INSTALL_INSTANTCLIENT:-"true"}

function install() {
    installers/shell-base.sh "${USERNAME}"

    if [[ "${INSTALL_INSTANTCLIENT}" == "true" ]]; then
        installers/oracle-instantclient.sh "${USERNAME}"
    fi
}

install