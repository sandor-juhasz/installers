#!/bin/bash
###############################################################################
#
# Installs the Git credential manager.
#
###############################################################################

set -e

USERNAME=${1:-$(id -un)}

source lib/common.sh

echo "Installing Git Credential manager..."

echo "Installing and configuring Git Credential Manager Core..."
if is_wsl; then
    su --login "$USERNAME" <<'EOF'
    git config --global credential.helper "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe"
    git config --global credential.https://dev.azure.com.useHttpPath true
EOF
else
    apt_install "dotnet-sdk-6.0"

    su --login "$USERNAME" <<'EOF'
        echo 'export PATH=$PATH:$HOME/.dotnet/tools' >~/.config/zshrc.d/dotnet.sh
        echo 'export PATH=$PATH:$HOME/.dotnet/tools' >~/.config/bashrc.d/dotnet.sh

        dotnet tool install -g git-credential-manager
        git-credential-manager configure
        # Configure the git credential manager to use the freedesktop.org Secret Service API
        git config --global credential.credentialStore secretservice
EOF

fi

