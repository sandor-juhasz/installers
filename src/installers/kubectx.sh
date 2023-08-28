#!/bin/bash
###############################################################################
#
# Installs the latest kubectx and kubens.
#
# Installation steps from 
# https://github.com/ahmetb/kubectx
###############################################################################

set -e

source lib/common.sh

USERNAME=${1:$(id -un)} 
if [[ "$USERNAME" == "root" ]]; then
    user_home_dir="/root"
else 
    user_home_dir="/home/$USERNAME"
fi


echo "Installing kubectx and kubens for $USERNAME..."

# TODO: Calculate version number dynamically.
kubectx_version="v0.9.5"

apt_install curl ca-certificates

#
# Installing kubectx
#
pushd /tmp || exit
echo "Downloading kubectx..."
curl -fsSL "https://github.com/ahmetb/kubectx/releases/download/${kubectx_version}/kubectx_${kubectx_version}_linux_x86_64.tar.gz" \
     -o "kubectx_${kubectx_version}_linux_x86_64.tar.gz"

echo "Extracting..."
tar xvzf "kubectx_${kubectx_version}_linux_x86_64.tar.gz"
echo "Installing binary..."
install kubectx "$user_home_dir/.local/bin" --owner=$USERNAME --group=$USERNAME
echo "Cleanup..."
rm "kubectx_${kubectx_version}_linux_x86_64.tar.gz"

#
# Installing kubens
#
echo "Downloading kubens..."
curl -fsSL "https://github.com/ahmetb/kubectx/releases/download/${kubectx_version}/kubens_${kubectx_version}_linux_x86_64.tar.gz" \
     -o "kubens_${kubectx_version}_linux_x86_64.tar.gz"     
echo "Extracting..."
tar xvzf "kubens_${kubectx_version}_linux_x86_64.tar.gz"
echo "Installing binary..."
install kubens "$user_home_dir/.local/bin" --owner=$USERNAME --group=$USERNAME
echo "Cleanup..."
rm "kubens_${kubectx_version}_linux_x86_64.tar.gz"

popd || exit

# TODO: Add shell autocompletion
