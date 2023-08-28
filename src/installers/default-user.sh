#!/bin/bash
###############################################################################
#
# Creates the default user if does not exist.
#
###############################################################################

source lib/common.sh

USERNAME=${1:-developer}
PASSWORD=welcome

if ! grep -q "1000:1000" /etc/passwd; then
    echo "User with UID 1000 was not found, creating...:"
    useradd -m -p "${PASSWORD}" -G sudo -s /bin/bash "${USERNAME}"
else
    echo "Found user with default UID, doing nothing."
fi
