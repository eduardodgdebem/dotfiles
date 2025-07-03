# My Dotfiles

These are my personal dotfiles for configuring my development environment.

## Installation

To install these dotfiles, run the following command from the root of this repository:

```bash
./scripts/set_sym_links.sh
```

This will create symbolic links for the necessary configuration files in your home directory.

## Managed Configurations

This repository manages the configuration for the following applications:

*   **Brew:** A list of installed packages can be found in the `brew` directory. The `brew/brew_install.sh` script helps manage these packages with the following commands:
    *   `install`: Installs all packages listed in the `brew_formulas` and `brew_casks` files.
    *   `sync`: Installs all packages from the lists and uninstalls any packages that are not on the lists.
    *   `u_list`: Updates the `brew_formulas` and `brew_casks` files with the currently installed packages.
*   **Ghostty:** Configuration for the Ghostty terminal emulator.
*   **Neovim:** My personal Neovim configuration, based on LazyVim.
*   **Tmux:** Configuration for the Tmux terminal multiplexer, including a Catppuccin theme.
*   **Zsh:** Configuration for the Zsh shell, including my personal `.zshrc` file.

## Wallpapers

This repository also includes a collection of my favorite wallpapers, which are located in the `wallpapers` directory. The installation script will create a symbolic link to this directory in `~/Pictures/wallpapers`.
