# shellcheck shell=bash
#
# Enabling Bash autocomplete for AWS CLI.
#
if [[ -e /usr/local/bin/aws_completer ]]; then
    complete -C /usr/local/bin/aws_completer aws
fi
