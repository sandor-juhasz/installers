#!/bin/bash -e
###############################################################################
#
# Installs latest jMeter
#
# TODO: - Calculate latest version of jmeter
#       - Check signature
#       - move checksum and signature check into the download function.
#       - Headless installation option, this will not require X libraries.
#
# TODO: Use sdkman instead.
# 
###############################################################################

USERNAME=${1:-$(id -un)}

source lib/common.sh

cd /tmp
mkdir /tmp/jmeter-installer
cd /tmp/jmeter-installer

echo "Downloading jmeter..."
download https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-5.6.3.tgz apache-jmeter-5.6.3.tgz
download https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-5.6.3.tgz.sha512 apache-jmeter-5.6.3.tgz.sha512

echo "Checking checksum..."
sha512sum -c apache-jmeter-5.6.3.tgz.sha512

echo "Installing..."
apt_install xterm libxtst6 libxi6
tar xvzf apache-jmeter-5.6.3.tgz
mv apache-jmeter-5.6.3 /opt
ln -s /opt/apache-jmeter-5.6.3 /opt/apache-jmeter

echo "Updating path..."
su --login "$USERNAME" <<EOF
    mkdir -p ~/.config/profile.d
    cat <<END >~/.config/profile.d/jmeter.sh
export PATH=\\\$PATH:/opt/apache-jmeter/bin
END
EOF

echo "Cleanup..."
rm -rf /tmp/jmeter-installer
