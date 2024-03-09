#!/bin/bash
###############################################################################
#
# Creates the default user if it does not exist.
#
###############################################################################

set -e

source lib/common.sh

USERNAME=${1:-developer}
PASSWORD=${2:-welcome}

if ! grep -q "1000:1000" /etc/passwd; then
    echo "User with UID 1000 was not found, creating..."
    useradd -m -p "$(openssl passwd -1 "$PASSWORD")" -G sudo -s /bin/bash "${USERNAME}"
    
    echo "Disabling Sudo password for $USERNAME..."
    echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers
    echo "Updating /etc/wsl.conf, setting default user."
    cat >/etc/wsl.conf <<EOF
[user]
default = ${USERNAME}
EOF
else
    USERNAME=$(grep 1000 /etc/passwd | awk -F ':' '{print $1}')
    echo "Found user with default UID with username $USERNAME."
    echo "Disabling Sudo password for $USERNAME..."
    echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers    
fi

