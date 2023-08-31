# shellcheck shell=bash
#
# Installs AWS development tools.
#
# Environment:
#    USERNAME                The user name of the user for which the feature is installed.
#

set -e

export INSTALL_AWS_CDK=${INSTALL_AWS_CDK:-"false"}
export INSTALL_AWS_SAM_CLI=${INSTALL_AWS_SAM_CLI:-"false"}

function install() {
    installers/shell-base.sh "${USERNAME}"
    installers/aws-cli.sh "${USERNAME}"

    if [[ "${INSTALL_AWS_CDK}" == "true" ]]; then
        installers/nvm.sh "${USERNAME}"
        installers/node.sh "${USERNAME}"
        installers/aws-cdk.sh "${USERNAME}"
    fi

    if [[ "${INSTALL_AWS_SAM_CLI}" == "true" ]]; then
        installers/aws-sam-cli.sh "${USERNAME}"
    fi
}

install
