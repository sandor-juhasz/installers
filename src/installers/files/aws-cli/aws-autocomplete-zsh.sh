# shellcheck shell=zsh
#
# Enabling Bash autocomplete for AWS CLI.
#

if [[ -e /usr/local/bin/aws_completer ]]; then
    autoload bashcompinit && bashcompinit
    autoload -Uz compinit && compinit
    complete -C '/usr/local/bin/aws_completer' aws
fi
