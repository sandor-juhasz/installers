#!/bin/bash
###############################################################################
#
# Installs Helm from the Debian repo.
#
###############################################################################

set -e

USERNAME=${1:-$(id -un)}

source lib/common.sh

echo "Installing the latest Helm..."

apt_install_prerequisites

apt_add_source -n helm \
    -d -k "https://baltocdn.com/helm/signing.asc" \
    -r "https://baltocdn.com/helm/stable/debian/" \
    -- "all main"

apt_install helm

su --login "$USERNAME" <<'EOF'
    echo "Setting up autocomplete for $USER"
    mkdir -p ~/.config/bashrc.d
    mkdir -p ~/.config/zshrc.d
    echo "source <(helm completion bash)" >~/.config/bashrc.d/helm_completion.sh
    echo "source <(helm completion zsh)" >~/.config/zshrc.d/helm_completion.sh
EOF
