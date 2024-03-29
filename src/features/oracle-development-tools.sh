# shellcheck shell=bash
#
# Installs the Oracle development tools.
#
# Environment:
#    USERNAME                The user name of the user for which the feature is installed.
#

set -e

export INSTALL_INSTANTCLIENT=${INSTALL_INSTANTCLIENT:-"true"}
export INSTALL_SQLCL=${INSTALL_SQLCL:-"false"}

function install() {
    installers/shell-base.sh "${USERNAME}"

    if [[ "${INSTALL_INSTANTCLIENT}" == "true" ]]; then
        installers/oracle-instantclient.sh "${USERNAME}"
    fi

    if [[ "${INSTALL_SQLCL}" == "true" ]]; then
        if ! which java >/dev/null; then
            installers/sdkman.sh "${USERNAME}"
            installers/java.sh "${USERNAME}" ""
        fi
        installers/oracle-sqlcl.sh "${USERNAME}"
    fi

}

install