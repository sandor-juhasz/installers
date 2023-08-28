#!/bin/bash
###############################################################################
#
# Installs Helm from the Debian repo.
#
###############################################################################

set -e

USERNAME=${1:-$(id -un)}

source lib/common.sh

echo "Installing the latest GitHub CLI..."

apt_install_prerequisites
apt_add_source -n github \
    -k "https://cli.github.com/packages/githubcli-archive-keyring.gpg" \
    -r "https://cli.github.com/packages" \
    -- "stable main"

apt_install gh

su --login "$USERNAME" <<'EOF'
    echo "Setting up autocomplete for $USER"
    mkdir -p ~/.config/bashrc.d
    mkdir -p ~/.config/zshrc.d
    echo "source <(gh completion -s bash)" >~/.config/bashrc.d/gh_completion.sh
    echo "source <(gh completion -s zsh)" >~/.config/zshrc.d/gh_completion.sh
EOF
