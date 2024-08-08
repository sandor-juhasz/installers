# shellcheck shell=bash
#
# Installs Snowflake development tools.
#
# Environment:
#    USERNAME                The user name of the user for which the feature is installed.
#    INSTALL_SNOWSQL         "true" if SnowSQL needs to be installed.
#    SNOWSQL_VERSION         The version of SnowSQL to be installed.
#

function install() {
    installers/shell-base.sh "${USERNAME}"
    
    if [[ "${INSTALL_SNOWSQL}" == "true" ]]; then
        installers/snowsql.sh "${USERNAME}" "${SNOWSQL_VERSION}"
    fi    
}

install