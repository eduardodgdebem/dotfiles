#!/bin/bash

if [ ! -f "$HOME/.zshrc" ]; then
  ln -s "$PWD/zsh/.zshrc" "$HOME/.zshrc"
else
  rm "$HOME/.zshrc"
  ln -s "$PWD/zsh/.zshrc" "$HOME/.zshrc"
fi

if [ ! -d "$HOME/Pictures/wallpapers" ]; then
  ln -s "$PWD/wallpapers" "$HOME/Pictures/wallpapers"
else
  rm -rf "$HOME/Pictures/wallpapers"
  ln -s "$PWD/wallpapers" "$HOME/Pictures/wallpapers"
fi

if [ ! -d "$HOME/.config/ghostty" ]; then
  ln -s "$PWD/ghostty" "$HOME/.config/ghostty"
else
  rm -rf "$HOME/.config/ghostty"
  ln -s "$PWD/ghostty" "$HOME/.config/ghostty"
fi
