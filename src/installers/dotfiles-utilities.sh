#!/bin/bash
#
# Installs general utilities.
#

set -e

USERNAME=${1:-$(id -un)}

source lib/common.sh

apt_add_source -n charm \
   -d -k "https://repo.charm.sh/apt/gpg.key" \
   -r "https://repo.charm.sh/apt/" \
   -- "* *"

apt_install exa htop mc ncdu powerline stow tmux gum

su --login "$USERNAME" <<'EOF'
    echo "Installing fzf from Github for user $USERNAME..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/share/fzf
    ~/.local/share/fzf/install --no-key-bindings --no-completion --no-update-rc
    mv ~/.fzf.bash ~/.config/bashrc.d/fzf.sh
    mv ~/.fzf.zsh ~/.config/zshrc.d/fzf.sh 
EOF

