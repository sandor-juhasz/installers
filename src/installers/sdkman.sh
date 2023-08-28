#!/bin/bash
###############################################################################
#
# Installs SDKMan in the user's home directory.
#
###############################################################################

USERNAME=${1:-$(id -un)}

source lib/common.sh

echo "Installing SDKMAN..."

if [[ "$USERNAME" == "root" ]]; then
    user_home_dir="/root"
else 
    user_home_dir="/home/$USERNAME"
fi

apt_install curl
as_user 'curl -s "https://get.sdkman.io?rcupdate=false" | bash'

install -T installers/files/sdkman/sdkman.sh "$user_home_dir/.config/bashrc.d/sdkman.sh" --owner=$USERNAME --group=$USERNAME
install -T installers/files/sdkman/sdkman.sh "$user_home_dir/.config/zshrc.d/sdkman.sh" --owner=$USERNAME --group=$USERNAME
install -T installers/files/sdkman/sdkman.sh "$user_home_dir/.config/profile.d/sdkman.sh" --owner=$USERNAME --group=$USERNAME
