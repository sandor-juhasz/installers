# shellcheck shell=bash
#
# Installs Snowflake development tools.
#
# Environment:
#    USERNAME                The user name of the user for which the feature is installed.
#    INSTALL_SNOWSQL         "true" if SnowSQL needs to be installed.
#    SNOWSQL_VERSION         The version of SnowSQL to be installed.
#

export INSTALL_SNOWSQL=${INSTALL_SNOWSQL:-"true"}
export INSTALL_SNOWFLAKE_CLI=${INSTALL_SNOWFLAKE_CLI:-"false"}

function install() {
    installers/shell-base.sh "${USERNAME}"
    
    if [[ "${INSTALL_SNOWSQL}" == "true" ]]; then
        installers/snowsql.sh "${USERNAME}" "${SNOWSQL_VERSION}"
    fi    

    if [[ "${INSTALL_SNOWFLAKE_CLI}" == "true" ]]; then
        export DEFAULT_PYTHON_VERSION="system"
        features/python-base-environment.sh
        installers/snowflake-cli.sh "${USERNAME}"
    fi    
}

install
