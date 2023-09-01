#!/bin/bash
###############################################################################
#
# Installs Docker Engine
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
