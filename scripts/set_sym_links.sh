#!/bin/bash

set -euo pipefail # Strict error handling

# --- Get the script's directory ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Functions ---

# Create or replace a symlink (with backup if needed)
safe_symlink() {
  local source="$1"
  local target="$2"

  if [ ! -e "$source" ]; then
    echo "❌ Error: Source '$source' does not exist."
    return 1
  fi

  if [ -L "$target" ]; then
    rm -f "$target"
    echo "🔗 Replaced existing symlink: $target"
  elif [ -e "$target" ]; then
    mv "$target" "$target.bak"
    echo "💾 Backed up existing file/dir: $target → $target.bak"
  fi

  mkdir -p "$(dirname "$target")"
  sudo ln -s "$source" "$target"
  echo "✅ Created symlink: $target → $source"
}

# --- Main Script ---

# Symlink .zshrc
safe_symlink "$SCRIPT_DIR/../zsh/.zshrc" "$HOME/.zshrc"

# Symlink wallpapers
safe_symlink "$SCRIPT_DIR/../wallpapers" "$HOME/Pictures/wallpapers"

# Symlink Ghostty config
GHOSTTY_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
safe_symlink "$SCRIPT_DIR/../ghostty/config" "$GHOSTTY_DIR/config"

# Symlink fastfetch
safe_symlink "$SCRIPT_DIR/../fastfetch" "$HOME/.config/fastfetch"

# Symlink nvim
safe_symlink "$SCRIPT_DIR/../nvim" "$HOME/.config/nvim"

# Symlink tmux
safe_symlink "$SCRIPT_DIR/../tmux" "$HOME/.config/tmux"
