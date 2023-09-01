#!/bin/bash
###############################################################################
#
# Installs Rust development tools with Rustup.
#
###############################################################################

set -e

USERNAME=${1:$(id -un)}

source lib/common.sh

cat <<EOF
Installing Rust toolchain...
============================
Parameters:
   USERNAME: $USERNAME

EOF

su --login "$USERNAME" <<'EOF'
    RUSTUP_HOME=~/.rustup
    CARGO_HOME=~/.cargo
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path 
    cat <<'END' >~/.config/profile.d/rust.sh
. "$HOME/.cargo/env"
END
EOF

echo "Done."
