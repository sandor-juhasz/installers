#!/bin/bash
###############################################################################
#
# Installs the Go runtime.
#
###############################################################################

set -e

USERNAME=${1:$(id -un)}

source lib/common.sh

cat <<EOF
Installing Go...
================
Parameters:
   USERNAME: $USERNAME

EOF

function latest_go_version() {
    list_go_versions | head -1
}

#
# Queries all available versions for Linux - AMD64.
#
# The function scrapes the Go download page.
#
function list_go_versions() {
    curl -s https://go.dev/dl/ | grep -Po '(?<=class="download" href="/dl/go).*(?=\.linux-amd64\.tar\.gz")' | sort -V -r
}

GO_VERSION="$(latest_go_version)"
GO_INSTALL_ROOT="/usr/local"
GO_INSTALL_DIR="${GO_INSTALL_ROOT}/go-${GO_VERSION}"
GO_SYMLINK_DIR="${GO_INSTALL_ROOT}/go"
GO_INSTALL_PACKAGE="go${GO_VERSION}.linux-amd64.tar.gz"
GO_INSTALL_PACKAGE_URL="https://go.dev/dl/${GO_INSTALL_PACKAGE}"

pushd /tmp || exit
wget "${GO_INSTALL_PACKAGE_URL}"
tar -xvzf "${GO_INSTALL_PACKAGE}"
if [[ -d "${GO_INSTALL_DIR}" ]]; then
    echo "Deleting previous Go install directory..."
    rm -rf "${GO_INSTALL_DIR}"
fi
mv go "${GO_INSTALL_DIR}"
ln -s "${GO_INSTALL_DIR}" "${GO_INSTALL_ROOT}/go"
rm "${GO_INSTALL_PACKAGE}"
popd || exit

su --login "$USERNAME" <<EOF
    mkdir -p ~/.config/profile.d
    cat <<END >~/.config/profile.d/go.sh
export GOROOT=${GO_SYMLINK_DIR}
export GOPATH=\\\$HOME/go
export GOBIN=\\\$GOPATH/bin
export PATH=\\\$PATH:\\\$GOROOT/bin
export PATH=\\\$PATH:\\\$GOPATH/bin
END
EOF

echo "Done."
