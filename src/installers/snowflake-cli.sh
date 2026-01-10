#!/bin/bash
###############################################################################
#
# Installs Snowflake CLI
#
# Installation instructions are added from the official installation guide at
# https://docs.snowflake.com/en/developer-guide/snowflake-cli-v2/installation/installation
###############################################################################

set -e

USERNAME=${1:$(id -un)}

source lib/common.sh

cat <<EOF
Installing Snowflake CLI...
===========================
Parameters:
   USERNAME: $USERNAME

EOF

su --login "$USERNAME" <<EOF
    if ! which pipx; then 
        echo "Cannot find pipx. Make sure you have installed the Python toolchain properly."
        exit 1;
    fi

    pipx install snowflake-cli

    snow --show-completion >~/.config/bashrc.d/snowflake-cli.sh
    snow --show-completion >~/.config/zshrc.d/snowflake-cli.sh
EOF

