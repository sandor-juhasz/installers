#!/bin/bash -e
###############################################################################
#
# Installs latest VisualVM using SDKMan in the user's home directory.
#
###############################################################################

USERNAME=${1:-$(id -un)}

source lib/common.sh

apt_install xterm libxtst6 libxi6

echo "Installing JDK Mission Control..."

# if [[ "$USERNAME" == "root" ]]; then
#     user_home_dir="/root"
# else 
#     user_home_dir="/home/$USERNAME"
# fi

as_user "sdk install jmc && sdk flush"
