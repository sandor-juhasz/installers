#!/bin/bash
###############################################################################
#
# Installs latest Maven in the user's home directory.
#
###############################################################################

USERNAME=${1:-$(id -un)}
MAVEN_VERSION=${2:-}

source lib/common.sh

echo "Installing Maven..."

# if [[ "$USERNAME" == "root" ]]; then
#     user_home_dir="/root"
# else 
#     user_home_dir="/home/$USERNAME"
# fi

as_user "sdk install maven ${MAVEN_VERSION} && sdk flush"
