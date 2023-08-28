# shellcheck shell=zsh
#
# Enabling Bash autocomplete for AWS CLI.
#

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws
