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
   USERNAME: $USERNAME
   DBT_CORE_PLUGINS: $DBT_CORE_PLUGINS

EOF

su --login "$USERNAME" <<EOF
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

