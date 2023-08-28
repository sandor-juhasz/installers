# shellcheck shell=bash
#
# Installs Terraform development tools.
#
# Environment:
#    USERNAME                The user name of the user for which the feature is installed.
#

function install() {
    installers/shell-base.sh "${USERNAME}"
    installers/terraform.sh "${USERNAME}"
}

install
