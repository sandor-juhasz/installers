#!/bin/bash
###############################################################################
#
# Installs Terraform CLI
#
###############################################################################

source lib/common.sh

USERNAME=${1:-$(id -un)}

echo "Installing ZSH..."
apt_install zsh

echo "Changing ${USERNAME}'s default shell to ZSH..."
chsh --shell /bin/zsh "${USERNAME}"

echo "Installing oh-my-zsh for $USERNAME..."
su --login "$USERNAME" <<'EOF'
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
EOF
