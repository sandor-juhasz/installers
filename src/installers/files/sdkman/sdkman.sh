# shellcheck shell=bash
#
# This file contains the chunk of .bashrc / .zshrc that the sdkman appends to the end
# of the files during installation.
#

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
