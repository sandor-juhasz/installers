# shellcheck shell=bash
#
# Installs Java development tools.
#
# Environment:
#    USERNAME                The user name of the user for which the feature is installed.
#

function install() {
    installers/shell-base.sh "${USERNAME}"
    installers/sdkman.sh "${USERNAME}"
    installers/java.sh "${USERNAME}" "${JAVA_VERSION}"
    
    if [[ "${INSTALL_MAVEN}" = "true" ]]; then
        installers/maven.sh "${USERNAME}" "${MAVEN_VERSION}"
    fi

    if [[ "${INSTALL_IJAVA_KERNEL}" = "true" ]]; then
        if [[ ! -d "/home/$USERNAME/.pyenv" ]]; then
            export DEFAULT_PYTHON_VERSION="system"
            features/python-base-environment.sh
        fi
        installers/ijava.sh "${USERNAME}"
    fi

    if [[ "${INSTALL_JMETER}" = "true" ]]; then
        installers/jmeter.sh "${USERNAME}"
    fi

}

install
