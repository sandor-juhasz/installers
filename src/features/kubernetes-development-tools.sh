# shellcheck shell=bash
#
# Installs the local Kubernetes development environment.
#
# Environment:
#    USERNAME                The user name of the user for which the feature is installed.
#

# export INSTALL_K3S="${INSTALL_K3S:-"false"}"
# export INSTALL_MINIKUBE="${INSTALL_MINIKUBE:-"false"}"
# export INSTALL_K3D="${INSTALL_K3D:-"false"}"
export INSTALL_KUBECTL="${INSTALL_KUBECTL:-"true"}"
export INSTALL_KUBECTX="${INSTALL_KUBECTX:-"true"}"
export INSTALL_HELM="${INSTALL_HELM:-"true"}"

function install() {
    installers/shell-base.sh "${USERNAME}"

    if [[ "${INSTALL_KUBECTL}" = "true" ]]; then
        installers/kubectl.sh "${USERNAME}"
    fi
    if [[ "${INSTALL_KUBECTX}" = "true" ]]; then
        installers/kubectx.sh "${USERNAME}"
    fi
    if [[ "${INSTALL_HELM}" = "true" ]]; then
        installers/helm.sh "${USERNAME}"
    fi
}

install
