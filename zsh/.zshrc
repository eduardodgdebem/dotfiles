# ------------------------------------------------------------------------------
# Exports
# ------------------------------------------------------------------------------
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$PATH:/Users/eduardogdebem/.dotnet/tools"
export NVM_DIR="$HOME/.nvm"
export HOMEBREW_PREFIX=$(brew --prefix) # Explicitly set Homebrew prefix
export XDG_CONFIG_HOME="$HOME/.config"

# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sbrew='~/Projects/dotfiles/brew/brew_install.sh'
alias c="c++ -std=c++26"
alias vim="nvim"

# ------------------------------------------------------------------------------
# Color Settings
# ------------------------------------------------------------------------------
if whence dircolors >/dev/null; then
  eval "$(dircolors -b)"
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  alias ls='ls --color'
  alias dir='dir --color'
  alias vdir='vdir --color'
  alias grep='grep --color'
  alias fgrep='fgrep --color'
  alias egrep='egrep --color'
else
  export CLICOLOR=1
  zstyle ':completion:*:default' list-colors ''
fi

# ------------------------------------------------------------------------------
# NVM (Node Version Manager)
# ------------------------------------------------------------------------------
# Load NVM
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
# Load NVM bash_completion
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"

# ------------------------------------------------------------------------------
# Starship Prompt
# ------------------------------------------------------------------------------
eval "$(starship init zsh)"

# ------------------------------------------------------------------------------
# Custom Completions
# ------------------------------------------------------------------------------
_brew_install_completions() {
  local -a commands=("install" "sync" "u_list")
  _describe 'sbrew commands' commands
}

compdef _brew_install_completions brew_install.sh sbrew

# ------------------------------------------------------------------------------
# Custom Functions 
# ------------------------------------------------------------------------------

cr() {
  c $@ -o a.out && ./a.out
}

# ------------------------------------------------------------------------------
# Local Settings
# ------------------------------------------------------------------------------
if [ -f "$HOME/.zsh_local" ] && [ -x "$HOME/.zsh_local" ]; then
    "$HOME/.zsh_local"
fi

# Run Fastfetch
fastfetch



# pnpm
export PNPM_HOME="/Users/eduardogdebem/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# Load Angular CLI autocompletion.
source <(ng completion script)
