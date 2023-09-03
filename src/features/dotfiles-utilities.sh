# shellcheck shell=bash
#
# Installs Dotfiles utilities
#
# Environment:
#    USERNAME                The user name of the user for which the feature is installed.
#

function install() {
    installers/shell-base.sh "${USERNAME}"
    installers/dotfiles-utilities.sh "${USERNAME}"
}

install
