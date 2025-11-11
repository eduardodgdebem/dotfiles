#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$SCRIPT_DIR/Brewfile"

input=$1

if [ -z "$input" ]; then
  echo "Usage: $0 [install|sync|update|cleanup]"
  echo ""
  echo "Commands:"
  echo "  install  - Install all packages from Brewfile"
  echo "  sync     - Install from Brewfile and remove unlisted packages"
  echo "  update   - Update Brewfile with currently installed packages"
  echo "  cleanup  - Remove packages not in Brewfile"
  exit 1
fi

check_brewfile() {
  if [ ! -f "$BREWFILE" ]; then
    echo "Error: Brewfile not found at $BREWFILE"
    echo "Run '$0 update' to create one from your current installations."
    exit 1
  fi
}

install_from_brewfile() {
  check_brewfile
  echo "Installing packages from Brewfile..."
  brew bundle install --file="$BREWFILE"
}

cleanup_unsynced() {
  check_brewfile
  echo "Removing packages not in Brewfile..."
  brew bundle cleanup --force --file="$BREWFILE"
}

update_brewfile() {
  echo "Updating Brewfile with currently installed packages..."
  brew bundle dump --force --file="$BREWFILE"
  echo "✓ Brewfile updated at $BREWFILE"
}

if [ "$input" = "install" ]; then
  echo "Installing all packages from Brewfile..."
  install_from_brewfile
  echo "✓ All packages have been installed."
  exit 0

elif [ "$input" = "sync" ]; then
  echo "Syncing packages with Brewfile..."
  install_from_brewfile
  echo ""
  cleanup_unsynced
  echo ""
  echo "✓ Sync complete! (Installed new packages, removed unlisted ones)"
  exit 0

elif [ "$input" = "update" ]; then
  update_brewfile
  exit 0

elif [ "$input" = "cleanup" ]; then
  echo "Cleaning up packages not in Brewfile..."
  cleanup_unsynced
  echo "✓ Cleanup complete!"
  exit 0

else
  echo "Error: Invalid argument. Use 'install', 'sync', 'update', or 'cleanup'."
  exit 1
fi
