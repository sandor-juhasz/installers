#!/bin/bash
###############################################################################
#
# Installs Docker Engine
#
# This install script can be used to install the latest Docker engine on a
# standalone Linux distro or on WSL. 
#
# On WSL the dockerd shuld be started in a separate terminal or some other
# init mechanism is necessary.
# TODO: try out the new WSL systemd support.
#       https://devblogs.microsoft.com/commandline/systemd-support-is-now-available-in-wsl/
#
# Note: Docker Engine cannot be used in tandem with Docker Desktop. They both
#       share state under /var/lib/docker.
#
###############################################################################

set -e

USERNAME=${1:$(id -un)}

source lib/common.sh

cat <<EOF
Installing Docker Engine...
===========================
Parameters:
   USERNAME: $USERNAME

EOF

apt_install_prerequisites
apt_add_source -n docker \
    -d -k "https://download.docker.com/linux/ubuntu/gpg" \
    -r "https://download.docker.com/linux/ubuntu" \
    -- "$(lsb_release -cs) stable"
apt_install docker-ce docker-ce-cli containerd.io docker-compose-plugin        

sudo usermod -a -G docker "${USERNAME}"

echo "Done."
