#!/bin/bash

# Use $HOME instead of ~
if [ ! -f "$HOME/.zshrc" ]; then
  ln -s "$PWD/zsh/.zshrc" "$HOME/.zshrc"
fi

if [ ! -d "$HOME/Pictures/wallpapers" ]; then # Use -d for directories
  ln -s "$PWD/wallpapers" "$HOME/Pictures/wallpapers"
fi
