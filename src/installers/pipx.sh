#!/bin/bash
###############################################################################
#
# Installs PIPX for the current user's default Python runtime.
#
# Environment:
#    USERNAME   The user for which pyenv is configured.
###############################################################################

source lib/common.sh

echo "Installing Python $PYTHON_VERSION for $USERNAME..."

as_user "mkdir -p ~/.local/bin"
as_user "pip install pipx "
as_user 'echo '\''eval "$(register-python-argcomplete pipx)"'\'' >~/.config/bashrc.d/pipx.sh'


su --login "$USERNAME" <<'EOF'
    echo 'eval "$(register-python-argcomplete pipx)"' >~/.config/bashrc.d/pipx.sh
    cat <<'END' >~/.config/zshrc.d/pipx.sh
autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"
END
EOF




