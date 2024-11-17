#!/bin/bash -e

echo "Installing the development enviornment."

DEFAULT_USERNAME=developer
DEFAULT_PASSWORD=welcome
INSTALL_DOCKER_ENGINE=false
INSTALL_DOTFILES=false
INSTALL_ZSH=false
for i in "$@"; do
  case $i in
    --install-zsh=*)
      INSTALL_ZSH="${i#*=}"
      shift
      ;;
    --install-dotfiles=*)
      INSTALL_DOTFILES="${i#*=}"
      shift
      ;;
    --install-docker-engine=*)
      INSTALL_DOCKER_ENGINE="${i#*=}"
      shift
      ;;
    --default-username=*)
      DEFAULT_USERNAME="${i#*=}"
      shift
      ;;
    --default-password=*)
      DEFAULT_PASSWORD="${i#*=}"
      shift
      ;;
    -*)
      echo "Unknown option $i"
      exit 1
      ;;
    *)
      ;;
  esac
done

set

optargs=""
if [[ "$INSTALL_DOTFILES" == "true" ]]; then
  optargs="$optargs --install-dotfiles"
fi
if [[ "$INSTALL_ZSH" == "true" ]]; then
  optargs="$optargs --install-zsh"
fi
if [[ "$INSTALL_DOCKER_ENGINE" == "true" ]]; then
  optargs="$optargs --install-docker-engine"
fi

cd /tmp
git clone https://github.com/sandor-juhasz/installers.git
cd installers/src
host-os-installers/wsl-ubuntu-installer --default-username=developer --default-password=welcome $optargs

