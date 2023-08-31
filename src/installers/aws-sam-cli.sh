#!/bin/bash
###############################################################################
#
# Installs AWS SAM CLI
#
###############################################################################

set -e

USERNAME=${1:$(id -un)}

source lib/common.sh

cat <<EOF
Installing AWS SAM CLI...
=========================
Parameters:
   USERNAME: $USERNAME

EOF

mkdir -p /tmp/sam-installation
curl -L https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip \
     -o /tmp/aws-sam-cli-linux-x86_64.zip
unzip /tmp/aws-sam-cli-linux-x86_64.zip -d /tmp/sam-installation
/tmp/sam-installation/install
rm -r /tmp/sam-installation
rm /tmp/aws-sam-cli-linux-x86_64.zip

echo "Done."
