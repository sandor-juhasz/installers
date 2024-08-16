#!/bin/bash
###############################################################################
#
# Installs DBT Cloud CLI
#
# Installation instructions are added from the official installation guide at
# https://docs.getdbt.com/docs/core/pip-install
###############################################################################

set -e

USERNAME=${1:$(id -un)}
VERSION=${2:-"0.38.10"}
EXECUTABLE_ALIAS=${3:-"dbt"}

source lib/common.sh

cat <<EOF
Installing dbt Cloud CLI...
===========================
Parameters:
   USERNAME:         $USERNAME
   VERSION:          $VERSION
   EXECUTABLE_ALIAS: $EXECUTABLE_ALIAS

EOF

echo "Downloading and extracting DBT cloud cli..."

mkdir -p /tmp/dbtcloud
download "https://github.com/dbt-labs/dbt-cli/releases/download/v${VERSION}/dbt_${VERSION}_linux_amd64.tar.gz" /tmp/dbtcloud/dbt.tgz
cd /tmp/dbtcloud
tar xvzf dbt.tgz

echo "Copying dbt cloud binary to user's home directory...."
su --login "$USERNAME" <<EOF
   cp /tmp/dbtcloud/dbt ~/.local/bin/${EXECUTABLE_ALIAS}   
EOF

echo "Cleanup..."
rm -rf /tmp/dbtcloud
