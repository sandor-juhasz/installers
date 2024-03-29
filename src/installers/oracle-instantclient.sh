#!/bin/bash
###############################################################################
#
# Installs Oracle Instant Client and its extensions like SQL*Plus.
#
# Installation steps are based on the official installation guide at 
# https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html
#
###############################################################################

set -e

USERNAME=${1:-$(id -un)}
ORACLE_INSTALL_DIR=${2:-/opt/oracle}
INSTANTCLIENT_TYPE="${INSTANTCLIENT_TYPE:-basic-light}"   # "basic" or "basic-light"
INSTALL_SQLPLUS="${INSTALL_SQLPLUS:-true}"
INSTALL_TOOLS="${INSTALL_TOOLS:-true}"
INSTALL_SDK="${INSTALL_SDK:-false}"
INSTALL_JDBC="${INSTALL_JDBC:-false}"
INSTALL_ODBC="${INSTALL_ODBC:-false}"

source lib/common.sh

function install_component() {
    local url=$1
    local filename=$(echo "$url" | rev | cut -d '/' -f 1 | rev)
    echo "Installing: $filename..."
    download "$url" "$filename"
    unzip "$filename"
    rm "$filename"
}

cat <<EOF
Oracle Instant Client Installer
===============================
Parameters:
   USERNAME:           $USERNAME
   ORACLE_INSTALL_DIR: $ORACLE_INSTALL_DIR
   INSTANTCLIENT_TYPE: $INSTANTCLIENT_TYPE
   INSTALL_SQLPLUS:    $INSTALL_SQLPLUS
   INSTALL_TOOLS:      $INSTALL_TOOLS
   INSTALL_SDK:        $INSTALL_SDK
   INSTALL_JDBC:       $INSTALL_JDBC
   INSTALL_ODBC:       $INSTALL_ODBC

EOF

echo "Installing dependencies..."
apt_install libaio1

echo "Creating installation directory..."
mkdir -p "${ORACLE_INSTALL_DIR}"
cd "${ORACLE_INSTALL_DIR}"

echo "Installing..."

if [[ "$INSTANTCLIENT_TYPE" == "basic" ]]; then
    echo "Installing Basic instant client..."
    install_component "https://download.oracle.com/otn_software/linux/instantclient/instantclient-basic-linuxx64.zip"
elif [[ "$INSTANTCLIENT_TYPE" == "basic-light" ]]; then
    echo "Installing Light instant client..."
    install_component "https://download.oracle.com/otn_software/linux/instantclient/instantclient-basiclite-linuxx64.zip"
else
    echo "Unknown instantclient type: $INSTANTCLIENT_TYPE. Must be 'basic' or 'basic-light'"
    exit 1
fi

if [[ "$INSTALL_SQLPLUS" == "true" ]]; then
    install_component "https://download.oracle.com/otn_software/linux/instantclient/instantclient-sqlplus-linuxx64.zip"
fi

if [[ "$INSTALL_TOOLS" == "true" ]]; then
    install_component "https://download.oracle.com/otn_software/linux/instantclient/instantclient-tools-linuxx64.zip"
fi

if [[ "$INSTALL_SDK" == "true" ]]; then
    install_component "https://download.oracle.com/otn_software/linux/instantclient/instantclient-sdk-linuxx64.zip"
fi

if [[ "$INSTALL_JDBC" == "true" ]]; then
    install_component "https://download.oracle.com/otn_software/linux/instantclient/instantclient-jdbc-linuxx64.zip"
fi

if [[ "$INSTALL_ODBC" == "true" ]]; then
    install_component "https://download.oracle.com/otn_software/linux/instantclient/instantclient-odbc-linuxx64.zip"
fi

echo "Detecting Instant client directory..."
instantclient_dir=$(/bin/ls -d -1 ${ORACLE_INSTALL_DIR}/instantclient* | head -1)
echo "    Found: $instantclient_dir"

echo "Adding libraries to the library path..."
echo "$instantclient_dir" >/etc/ld.so.conf.d/oracle-instantclient.conf
ldconfig

echo "Adding Oracle Instant Client directory to the path for $USERNAME..."
su --login "$USERNAME" <<EOF
    echo "Creating ~/.config/profile.d/oracle-instantclient.sh..."
    cat <<'END' >~/.config/profile.d/oracle-instantclient.sh
export PATH=\$PATH:$instantclient_dir
END

EOF

echo "Done."
