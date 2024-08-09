# shellcheck shell=bash
#
# Installs dbt development tools.
#
# Environment:
#    USERNAME                The user name of the user for which the feature is installed.
#    INSTALL_DBT_CORE         "true" if dbt core is installed.
#    DBT_CORE_PLUGINS        Space separated list of plugin names.
#

export INSTALL_SNOWSQL=${INSTALL_SNOWSQL:-"true"}
export DBT_CORE_PLUGINS=${DBT_CORE_PLUGINS:-""}

function install() {
    installers/shell-base.sh "${USERNAME}"
    
    if [[ "${INSTALL_DBT_CORE}" == "true" ]]; then
        export DEFAULT_PYTHON_VERSION="system"
        features/python-base-environment.sh
        installers/dbt-core.sh "${USERNAME}" "${DBT_CORE_PLUGINS}"
    fi    
}

install
