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
}

install
