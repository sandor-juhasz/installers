#!/bin/bash
###############################################################################
#
# Installs Microsoft Visual Studio Code
#
###############################################################################

source lib/common.sh

USERNAME=${1:-$(id -un)}

echo "Installing Visual Studio Code..."
if is_wsl; then
    echo "VSCode should not be installed in the WSL distro. Skipping this step..."
else
    echo "Not WSL distro, installing VSCode."
    apt_add_source -n vscode \
        -d -k "https://packages.microsoft.com/keys/microsoft.asc" \
        -r "https://packages.microsoft.com/repos/code" \
        -- "stable main"
    apt_install code
fi
