#!/bin/bash
###############################################################################
#
# Installs AWS CLI and session manager plugin
#
###############################################################################

USERNAME=${1:$(id -un)}

source lib/common.sh

echo "Installing AWS CLI..."

if [[ "$USERNAME" == "root" ]]; then
    user_home_dir="/root"
else 
    user_home_dir="/home/$USERNAME"
fi

apt_install curl unzip
pushd /tmp || exit
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -r aws
rm awscliv2.zip
popd

echo "Installing AWS CLI Session Manager plugin..."
curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "/tmp/session-manager-plugin.deb"
dpkg -i /tmp/session-manager-plugin.deb
rm /tmp/session-manager-plugin.deb

echo "Enabling autocomplete for user '${USERNAME}'..."
install -T installers/files/aws-cli/aws-autocomplete.sh "$user_home_dir/.config/bashrc.d/aws-autocomplete.sh" --owner=$USERNAME --group=$USERNAME
install -T installers/files/aws-cli/aws-autocomplete-zsh.sh "$user_home_dir/.config/zshrc.d/aws-autocomplete.sh" --owner=$USERNAME --group=$USERNAME
