#!/bin/bash
###############################################################################
#
# Installs DBT Core CLI
#
# Installation instructions are added from the official installation guide at
# https://docs.getdbt.com/docs/core/pip-install
###############################################################################

set -e

USERNAME=${1:$(id -un)}
DBT_CORE_PLUGINS=${2:-""}
source lib/common.sh

cat <<EOF
Installing dbt Core...
===========================
Parameters:
   USERNAME:                $USERNAME
   DBT_CORE_PLUGINS:        $DBT_CORE_PLUGINS
   DBT_CORE_INSTALL_METHOD: $DBT_CORE_INSTALL_METHOD

EOF

if [[ "${DBT_CORE_INSTALL_METHOD}" == "pipx" ]]; then
  su --login "$USERNAME" <<EOF
    echo "Installing dbt Core using pipx..."
    if ! which pipx; then 
        echo "Cannot find pipx. Make sure you have installed the Python toolchain properly."
        exit 1;
    fi

    pipx install dbt-core

    if [[ ! -z "$DBT_CORE_PLUGINS" ]]; then
       echo "DBT Plugins found."
       for plugin in ${DBT_CORE_PLUGINS}; do
          echo Installing "\$plugin"
          pipx inject dbt-core "\$plugin"
       done
    else
       echo "No plugins were specified."
    fi   
EOF
elif [[ "${DBT_CORE_INSTALL_METHOD}" == "pyenv-virtualenv" ]]; then
  su --login "$USERNAME" <<EOF
    echo "Installing dbt Core into a pyenv virtualenv..."
    pyenv virtualenv dbt
    pyenv activate dbt
    pip install dbt-core

    if [[ ! -z "$DBT_CORE_PLUGINS" ]]; then
       echo "DBT Plugins found."
       for plugin in ${DBT_CORE_PLUGINS}; do
          echo Installing "\$plugin"
          pip install "\$plugin"
       done
    else
       echo "No plugins were specified."
    fi   
    pyenv deactivate
EOF
elif [[ "${DBT_CORE_INSTALL_METHOD}" == "user-python" ]]; then
  su --login "$USERNAME" <<EOF
    echo "Installing dbt Core into the user's python environment."
    pip install dbt-core

    if [[ ! -z "$DBT_CORE_PLUGINS" ]]; then
       echo "DBT Plugins found."
       for plugin in ${DBT_CORE_PLUGINS}; do
          echo Installing "\$plugin"
          pip install "\$plugin"
       done
    else
       echo "No plugins were specified."
    fi   
EOF
else
    echo "Unknown install method ${DBT_CORE_INSTALL_METHOD}, exiting..."
    exit 1
fi
