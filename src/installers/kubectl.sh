#!/bin/bash
###############################################################################
#
# Installs the latest Kubectl.
#
# Installation steps from 
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
###############################################################################

set -e

USERNAME=${1:-$(id -un)}
echo User: $USERNAME

source lib/common.sh

echo "Installing Kubectl..."

apt_install_prerequisites

apt_add_source -n kubernetes \
    -d -k "https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key" \
    -r "https://pkgs.k8s.io/core:/stable:/v1.28/deb/" \
    -- "/"

apt_install bash-completion kubectl

su --login "$USERNAME" <<'EOF'
    echo "Setting up autocomplete for $USER"
    mkdir -p ~/.config/bashrc.d
    mkdir -p ~/.config/zshrc.d
    echo "source <(kubectl completion bash)" >~/.config/bashrc.d/kubectl_completion.sh
    echo "source <(kubectl completion zsh)" >~/.config/zshrc.d/kubectl_completion.sh
EOF
