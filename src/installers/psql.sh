#!/bin/bash
###############################################################################
#
# Installs PostgreSQL client tools
#
###############################################################################

source lib/common.sh

USERNAME=${1:-$(id -un)}

apt_install_prerequisites
apt_add_source -n pgdg \
    -d -k "https://www.postgresql.org/media/keys/ACCC4CF8.asc" \
    -r "https://apt.postgresql.org/pub/repos/apt" \
    -- "$(lsb_release -cs)-pgdg main"

apt_install postgresql-client
