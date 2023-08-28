#!/bin/bash
###############################################################################
# This script installs the base configuration of the shell initializer file
# structure. This script must be run as a user.
#
# TODO: refactor, eliminate duplicates.
###############################################################################

if [[ "$(id -u)" = "0" ]]; then
    echo "This script must be run as a user and not as root."
    exit 1
fi

mkdir -p ~/.config/bashrc.d \
         ~/.config/profile.d \
         ~/.config/zshrc.d \
         ~/.local/bin

if [[ ! -e ~/.bashrc ]] || ! grep -q '>>> ~/.config/bashrc.d support >>>' ~/.bashrc ; then 
    echo "Updating ~/.bashrc"
    cat <<'EOF' >>~/.bashrc
# >>> ~/.config/bashrc.d support >>>

if [[ -d ~/.config/bashrc.d ]]; then
    for file in ~/.config/bashrc.d/*.sh; do
        if [[ -r $file ]]; then
            source "${file}"
        fi
    done
    unset file
fi

# <<< ~/.config/bashrc.d support <<<
EOF
else
    echo "Skipping ~/.bashrc, already modified."
fi


if [[ ! -e ~/.profile ]] || ! grep -q '>>> ~/.config/profile.d support >>>' ~/.profile ; then 
    echo "Updating ~/.profile"
    cat <<'EOF' >>~/.profile
# >>> ~/.config/profile.d support >>>

if [ -d "$HOME/.config/profile.d" ]; then
  for i in "$HOME/.config/profile.d"/*.sh; do
    if [ -r "$i" ]; then
      . "$i"
    fi
  done
  unset i
fi

# <<< ~/.config/profile.d support <<<
EOF
else
    echo "Skipping ~/.profile, already modified."
fi

if [[ ! -e ~/.zshrc ]] || ! grep -q '>>> ~/.config/zshrc.d support >>>' ~/.zshrc ; then 
    echo "Updating ~/.zshrc"
    cat <<'EOF' >>~/.zshrc
# >>> ~/.config/zshrc.d support >>>

if [[ -d ~/.config/zshrc.d ]]; then
    for file in ~/.config/zshrc.d/*.sh; do
        if [[ -r $file ]]; then
            source "${file}"
        fi
    done
    unset file
fi

# <<< ~/.config/zshrc.d support <<<
EOF
else
    echo "Skipping ~/.zshrc, already modified."
fi

if [[ ! -e ~/.zprofile ]] || ! grep -q '>>> ~/.config/profile.d support >>>' ~/.zprofile ; then 
    echo "Updating ~/.zprofile"
    cat <<'EOF' >>~/.zprofile
# >>> ~/.config/profile.d support >>>

if [[ -d ~/.config/profile.d ]]; then
    for file in ~/.config/profile.d/*.sh; do
        if [[ -r $file ]]; then
            source "${file}"
        fi
    done
    unset file
fi

# <<< ~/.config/profile.d support <<<
EOF
else
    echo "Skipping ~/.zprofile, already modified."
fi
