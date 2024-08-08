#!/bin/bash
###############################################################################
#
# Installs Snowflake SnowSQL CLI
#
# Installation instructions are added from the official installation guide at
# https://docs.snowflake.com/en/user-guide/snowsql-install-config
###############################################################################

set -e

USERNAME=${1:$(id -un)}

source lib/common.sh

SNOWSQL_VERSION=${2:-"1.3.1"}
SNOWSQL_DEST_PATH="/home/$USERNAME/.local/bin"
TMP_INSTALLER_DIR="/tmp/snowsql"

cat <<EOF
Installing SnowSQL...
=====================
Parameters:
   USERNAME:          $USERNAME
   SNOWSQL_VERSION:   $SNOWSQL_VERSION
   SNOWSQL_DEST_PATH: $SNOWSQL_DEST_PATH
   TMP_INSTALLER_DIR: $TMP_INSTALLER_DIR

EOF

BOOTSTRAP_VERSION=$(echo "$SNOWSQL_VERSION" | sed -e 's/\(^[[:digit:]]\+\.[[:digit:]]\+\)\.[[:digit:]]\+$/\1/')
SNOWSQL_INSTALLER="snowsql-${SNOWSQL_VERSION}-linux_x86_64.bash"
SNOWSQL_INSTALLER_SIG="snowsql-${SNOWSQL_VERSION}-linux_x86_64.bash.sig"
SNOWSQL_INSTALLER_URL="https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/${BOOTSTRAP_VERSION}/linux_x86_64/${SNOWSQL_INSTALLER}"
SNOWSQL_INSTALLER_SIG_URL="https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/${BOOTSTRAP_VERSION}/linux_x86_64/${SNOWSQL_INSTALLER_SIG}"

cat <<EOF
Calculated variables...
=====================
Parameters:
   BOOTSTRAP_VERSION:         $BOOTSTRAP_VERSION
   SNOWSQL_INSTALLER:         $SNOWSQL_INSTALLER
   SNOWSQL_INSTALLER_SIG:     $SNOWSQL_INSTALLER_SIG
   SNOWSQL_INSTALLER_URL:     $SNOWSQL_INSTALLER_URL
   SNOWSQL_INSTALLER_SIG_URL: $SNOWSQL_INSTALLER_SIG_URL

EOF

echo "Creating temp dir..."
mkdir -p "${TMP_INSTALLER_DIR}"

echo "Downloading the installer..."
download "$SNOWSQL_INSTALLER_URL" "${TMP_INSTALLER_DIR}/$SNOWSQL_INSTALLER"

echo "Downloading the signature..."
download "$SNOWSQL_INSTALLER_SIG_URL" "${TMP_INSTALLER_DIR}/$SNOWSQL_INSTALLER_SIG"

echo "Adding Snowflake GPG key to keyring..."
gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 630D9F3CAB551AF3

echo "Verifying signature..."
gpg --verify "${TMP_INSTALLER_DIR}/$SNOWSQL_INSTALLER_SIG" "${TMP_INSTALLER_DIR}/$SNOWSQL_INSTALLER"

echo "Deleting the Snowflake GPG key from the keyring..."
gpg --batch --yes --delete-key "Snowflake Computing"


# Run installer as user
# Note: The installer adds the $SNOWSQL_DEST directory to the shell config file. As this path is
# already in the PATH, the script should not add it twice. Unfortunately the installer script
# is not silent if it cannot add the path to a file so we pass a placeholder that we delete.
su --login "$USERNAME" <<EOF
    mkdir -p "$SNOWSQL_DEST_PATH"
    cd /tmp/snowsql
    touch /tmp/delme.sh
    SNOWSQL_DEST="$SNOWSQL_DEST_PATH" SNOWSQL_LOGIN_SHELL=/tmp/delme.sh bash "${TMP_INSTALLER_DIR}/${SNOWSQL_INSTALLER}"
    rm /tmp/delme.sh
EOF

rm -rf "${TMP_INSTALLER_DIR}"
