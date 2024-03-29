#!/bin/bash
###############################################################################
#
# Installs Oracle SQLcl
#
# Installation steps are based on the official installation guide at 
# https://www.oracle.com/database/sqldeveloper/technologies/sqlcl/download/
#
###############################################################################

set -e

USERNAME=${1:-$(id -un)}
ORACLE_INSTALL_DIR=${2:-/opt/oracle}

source lib/common.sh

cat <<EOF
Oracle SQLcl Installer
===============================
Parameters:
   USERNAME:           $USERNAME
   ORACLE_INSTALL_DIR: $ORACLE_INSTALL_DIR

EOF

echo "Creating installation directory..."
mkdir -p "${ORACLE_INSTALL_DIR}"
cd "${ORACLE_INSTALL_DIR}"

echo "Installing..."
download "https://download.oracle.com/otn_software/java/sqldeveloper/sqlcl-latest.zip" "sqlcl-latest.zip"
unzip "sqlcl-latest.zip"
rm "sqlcl-latest.zip"

echo "Adding Oracle SQLcl to the path for $USERNAME..."
su --login "$USERNAME" <<EOF
    echo "Creating ~/.config/profile.d/oracle-sqlcl.sh..."
    cat <<'END' >~/.config/profile.d/oracle-sqlcl.sh
export PATH=\$PATH:$ORACLE_INSTALL_DIR/sqlcl/bin
END

EOF

echo "Done."
