# shellcheck shell=bash
#
# Installs Rust development tools.
#
# Environment:
#    USERNAME                The user name of the user for which the feature is installed.
#

function install() {
    installers/shell-base.sh "${USERNAME}"
    installers/rust.sh "${USERNAME}"
}

install
