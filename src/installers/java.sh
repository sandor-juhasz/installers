#!/bin/bash
###############################################################################
#
# Installs latest LTS JDK using SDKMan in the user's home directory.
#
###############################################################################

USERNAME=${1:-$(id -un)}
JAVA_VERSION=${2:-}

source lib/common.sh

echo "Installing Java..."

# if [[ "$USERNAME" == "root" ]]; then
#     user_home_dir="/root"
# else 
#     user_home_dir="/home/$USERNAME"
# fi

as_user "sdk install java ${JAVA_VERSION} && sdk flush"
