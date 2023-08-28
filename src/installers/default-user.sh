#!/bin/bash
###############################################################################
#
# Creates the default user if does not exist.
#
###############################################################################

set -e

source lib/common.sh

USERNAME=${1:-developer}
PASSWORD=welcome

if ! grep -q "1000:1000" /etc/passwd; then
    echo "User with UID 1000 was not found, creating..."
    useradd -m -p "$(openssl passwd -1 "$PASSWORD")" -G sudo -s /bin/bash "${USERNAME}"

    echo "Updating /etc/wsl.conf, setting default user."
    cat >/etc/wsl.conf <<EOF
[user]
default = ${USERNAME}
EOF
else
    echo "Found user with default UID, doing nothing."
fi
