#!/bin/bash
#
# Installs general utilities.
#

set -e

source lib/common.sh
apt_install wget jq
wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq
chmod +x /usr/local/bin/yq
