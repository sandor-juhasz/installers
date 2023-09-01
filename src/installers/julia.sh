#!/bin/bash
###############################################################################
#
# Installs Julia development tools with Juliaup.
#
###############################################################################

set -e

USERNAME=${1:$(id -un)}

source lib/common.sh

cat <<EOF
Installing Julia toolchain...
=============================
Parameters:
   USERNAME: $USERNAME

EOF

su --login "$USERNAME" <<'EOF'
    set -e

    curl -fsSL https://install.julialang.org | sh -s -- -y

    echo "Creating julia.sh files..."
    cat ~/.bashrc | sed -n '/^# >>> juliaup initialize >>>/,/^# <<< juliaup initialize <<</{p;/^pattern2/q}' >~/.config/bashrc.d/julia.sh
    cat ~/.profile | sed -n '/^# >>> juliaup initialize >>>/,/^# <<< juliaup initialize <<</{p;/^pattern2/q}' >~/.config/profile.d/julia.sh
    cat ~/.zshrc | sed -n '/^# >>> juliaup initialize >>>/,/^# <<< juliaup initialize <<</{p;/^pattern2/q}' >~/.config/zshrc.d/julia.sh

    echo "Deleting Julia initializers from rc files..."
    sed -i '/^# >>> juliaup initialize >>>/,/^# <<< juliaup initialize <<</d' ~/.bashrc
    sed -i '/^# >>> juliaup initialize >>>/,/^# <<< juliaup initialize <<</d' ~/.profile
    sed -i '/^# >>> juliaup initialize >>>/,/^# <<< juliaup initialize <<</d' ~/.zshrc
EOF

echo "Done."
