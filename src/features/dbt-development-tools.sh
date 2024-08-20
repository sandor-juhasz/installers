# shellcheck shell=bash
#
# Installs dbt development tools.
#
# Environment:
#    USERNAME                The user name of the user for which the feature is installed.
#    INSTALL_DBT_CORE         "true" if dbt core needs to be installed.
#    DBT_CORE_PLUGINS        Space separated list of plugin names.
#    DBT_CORE_INSTALL_METHOD Possible values: "user-python", "pyenv-virtualenv", "pipx"
#    INSTALL_DBT_CLOUD_CLI   "true" if dbt cloud cli needs to be installed. "false" by default
#    DBT_CLOUD_CLI_VERSION   Version number.
#    DBT_CLOUD_CLI_ALIAS     The name of the executable of the dbt cloud cli. "dbt" by default
#                            but useful if both dbt core and the cloud cli gets installed
#                            at the same time.
#

export INSTALL_SNOWSQL=${INSTALL_SNOWSQL:-"true"}
export DBT_CORE_PLUGINS=${DBT_CORE_PLUGINS:-""}
export DBT_CORE_INSTALL_METHOD="${DBT_CORE_INSTALL_METHOD:-"pyenv-virtualenv"}"
export INSTALL_DBT_CLOUD_CLI=${INSTALL_DBT_CLOUD_CLI:-"false"}
export DBT_CLOUD_CLI_VERSION=${DBT_CLOUD_CLI_VERSION:-"0.38.10"}
export DBT_CLOUD_CLI_ALIAS=${DBT_CLOUD_CLI_ALIAS:-"dbt"}

function install() {
    installers/shell-base.sh "${USERNAME}"
    
    if [[ "${INSTALL_DBT_CORE}" == "true" && "${INSTALL_DBT_CLOUD_CLI}" == "true" && "${DBT_CLOUD_CLI_ALIAS}" == "dbt" ]]; then
        echo "DBT Core and DBT Cloud CLI has both use 'dbt' as the command name. Specify a dbtCloudCLIAlias option value."
        exit 1
    fi

    if [[ "${INSTALL_DBT_CORE}" == "true" ]]; then
        echo "Looking for installed Python feature..."
        if [[ ! -d "/home/${USERNAME}/.pyenv" ]]; then
            echo "Python feature was not found, installing with System python..."
            export DEFAULT_PYTHON_VERSION="system"
            features/python-base-environment.sh
        else
            echo "Pyenv was found in the users home directory, assuming the Python feature is installed properly."
        fi
        installers/dbt-core.sh "${USERNAME}" "${DBT_CORE_PLUGINS}" "${DBT_CORE_INSTALL_METHOD}"
    fi    

    if [[ "${INSTALL_DBT_CLOUD_CLI}" == "true" ]]; then
        installers/dbt-cloud-cli.sh "${USERNAME}" "${DBT_CLOUD_CLI_VERSION}" "${DBT_CLOUD_CLI_ALIAS}"
    fi
}

install
