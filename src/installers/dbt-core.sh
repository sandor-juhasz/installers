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

source lib/common.sh

cat <<EOF
Installing dbt Core...
===========================
Parameters:
   USERNAME: $USERNAME

EOF

su --login "$USERNAME" <<EOF
    if ! which pipx; then 
        echo "Cannot find pipx. Make sure you have installed the Python toolchain properly."
        exit 1;
    fi

    pipx install dbt-core
EOF
