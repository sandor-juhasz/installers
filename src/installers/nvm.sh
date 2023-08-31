#!/bin/bash
###############################################################################
#
# Installs NVM, the Node version manager.
#
###############################################################################

set -e

USERNAME=${1:-$(id -un)}

source lib/common.sh

cat <<EOF
Installing NVM...
=================
Parameters:
   USERNAME: $USERNAME

EOF

su --login "$USERNAME" <<'EOF'
    PROFILE=/dev/null bash -c "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash"

    echo "Creating ~/.config/bashrc.d/nvm.sh..."
    cat <<'END' >~/.config/bashrc.d/nvm.sh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
END

    echo "Creating ~/.config/zshrc.d/nvm.sh..."
    cat <<'END' >~/.config/zshrc.d/nvm.sh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
END

    echo "Creating ~/.config/profile.d/nvm.sh..."
    cat <<'END' >~/.config/profile.d/nvm.sh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
END

EOF

echo "Done."
