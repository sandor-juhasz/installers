#!/bin/bash
###############################################################################
#
# Installs Terraform CLI
#
###############################################################################

source lib/common.sh

USERNAME=${1:-$(id -un)}

apt_install_prerequisites
apt_add_source -n hashicorp \
    -d -k "https://apt.releases.hashicorp.com/gpg" \
    -r "https://apt.releases.hashicorp.com" \
    -- "$(lsb_release -cs) main"

apt_install terraform

su --login "$USERNAME" <<'EOF'
    echo "Setting up autocomplete for $USER"
    mkdir -p ~/.config/bashrc.d
    mkdir -p ~/.config/zshrc.d
    echo "complete -C /usr/bin/terraform terraform" >~/.config/bashrc.d/terraform_completion.sh
    echo "autoload -U +X bashcompinit && bashcompinit" >~/.config/zshrc.d/terraform_completion.sh
    echo "complete -o nospace -C /usr/bin/terraform terraform" >>~/.config/zshrc.d/terraform_completion.sh
EOF
