#!/bin/bash
###############################################################################
#
# Installs Snowflake CLI
#
# Installation instructions are added from the official installation guide at
# https://docs.snowflake.com/developer-guide/snowflake-cli/installation/installation
#
# Note: The old way of installing Snowflake CLI through pip has been deprecated.
#       The recommended way is to use the binary DEB/RPM packages downloaded 
#       from the Snowflake repository server.
#
###############################################################################

set -e

USERNAME=${1:$(id -un)}
SNOWFLAKE_CLI_VERSION=${2:-"3.14.0"}

source lib/common.sh

cat <<EOF
Installing Snowflake CLI...
===========================
Parameters:
   USERNAME:              $USERNAME
   SNOWFLAKE_CLI_VERSION: $SNOWFLAKE_CLI_VERSION

EOF

if [[ "$SNOWFLAKE_CLI_VERSION" == "pipx" ]]; then
    echo "Pipx installation method is detected."
    su --login "$USERNAME" <<EOF
        if ! which pipx; then 
            echo "Cannot find pipx. Make sure you have installed the Python toolchain properly."
            exit 1;
        fi

        pipx install snowflake-cli

        snow --show-completion >~/.config/bashrc.d/snowflake-cli.sh
        snow --show-completion >~/.config/zshrc.d/snowflake-cli.sh
EOF
else 
    echo "DEB installation method is detected."
    echo "Downloading deb package..."
    DEB_URL="https://sfc-repo.snowflakecomputing.com/snowflake-cli/linux_x86_64/${SNOWFLAKE_CLI_VERSION}/snowflake-cli-${SNOWFLAKE_CLI_VERSION}.x86_64.deb"
    DEB_FILENAME="/tmp/snowflake-cli-${SNOWFLAKE_CLI_VERSION}.x86_64.deb"
    download "${DEB_URL}" "${DEB_FILENAME}"
    echo "Installing deb package..."
    dpkg -i "${DEB_FILENAME}"
    echo "Cleanup..."
    rm "${DEB_FILENAME}"
fi
