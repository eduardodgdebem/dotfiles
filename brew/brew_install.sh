#!/bin/bash

# Auto-completion for script arguments
_brew_installer_completions() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY=($(compgen -W "install sync u_list" -- "$cur"))
}

# Register completion function
complete -F _brew_installer_completions ./brew_installer.sh

input=$1

if [ -z "$input" ]; then
  echo "Usage: $0 [install|sync]"
  exit 1
fi

install_from_list() {
  echo "Installing missing formulas..."
  comm -23 <(sort brew_formulas) <(brew leaves | sort) | xargs brew install

  echo "Installing missing casks..."
  comm -23 <(sort brew_casks) <(brew list --cask | sort) | xargs brew install --cask
}

remove_unsynced_package() {
  echo "Removing unsynced formulas..."
  comm -23 <(brew leaves | sort) <(sort brew_formulas) | xargs brew uninstall --force
  echo "Removing unsynced formulas..."
  comm -23 <(brew list --cask | sort) <(sort brew_casks) | xargs brew uninstall --cask --force
}

if [ "$input" = "install" ]; then
  echo "Installing all packages..."
  install_from_list
  echo "All packages on the list have been processed."
  exit 0

elif [ "$input" = "sync" ]; then
  echo "Syncing packages..."
  install_from_list
  remove_unsynced_package

  echo "Sync complete! (Installed new packages, removed old ones)"
  exit 0

elif [ "$input" = "u_list" ]; then
  echo "Syncing..."
  brew leaves >brew_formulas
  brew ls --cask >brew_casks

  echo "All packages are synced"
  exit 0

else
  echo "Error: Invalid argument. Use 'install' or 'sync'."
  exit 1
fi
